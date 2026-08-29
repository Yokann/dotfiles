# Design notes

Quickshell 0.3 bar for Hyprland. Read this before adding or changing anything.

## Layout

```
shell.qml            ShellRoot, imports modules/bar
settings.json         user config, committed with sane defaults
config/
  Settings.qml         Singleton: FileView + JsonAdapter over settings.json
theme/
  Colors.qml             Singleton: Catppuccin Macchiato palette
  Metrics.qml             Singleton: shared spacing/radius/font sizes
ui/
  Pill.qml                 reusable clickable bar-item chrome
  Popup.qml                 reusable popup chrome (background, LazyLoader-friendly)
widgets/
  Registry.qml             Singleton: static id -> Component map
  <name>/                   one self-contained widget per directory
modules/
  bar/Bar.qml               One bar, parameterized by a bar config; Variants over
                             Quickshell.screens, one PanelWindow per screen
services/
  <Name>.qml                Singleton wrapping a system integration (added as needed per widget)
```

`shell.qml` instantiates one `Bar { barConfig: ... }` per entry of `Settings.bars` (`Variants { model: Settings.bars }`) — this is what makes multiple bars possible, see Settings below.

All internal imports use `import qs.<path>` (resolved relative to `shell.qml` by Quickshell itself — no manual `qmldir`).

## Settings

`settings.json` has a `bars` array (each entry: identity, geometry, and per-screen layout) and a `widgets` dictionary keyed by **instance id** for widget-specific settings:

```json
{
  "bars": [
    {
      "id": "main",
      "position": "top",
      "height": 34,
      "layout": {
        "default": { "left": ["clock_date", "clock_time"] },
        "HDMI-1": { "left": ["clock_time", "pomodoro"] }
      }
    },
    {
      "id": "secondary",
      "position": "bottom",
      "height": 34,
      "layout": { "default": { "left": ["placeholder"] } }
    }
  ],
  "widgets": {
    "clock_time": { "type": "clock", "format": "HH:mm" },
    "clock_date": { "type": "clock", "format": "dddd d MMMM" },
    "pomodoro": { "workMinutes": 25 }
  }
}
```

Each `bars[]` entry becomes one independent bar, rendered on every screen (`shell.qml`: `Variants { model: Settings.bars }` instantiating `Bar { barConfig: ... }`) — `id` just needs to be unique per entry, it isn't otherwise interpreted. `Settings.bars` is computed by merging each raw entry over `{ id: "main", position: "top", height: 34, layout: {} }` in `Settings.qml`, so a `bars[]` entry can omit any field it doesn't need to override. (A `list<JsonObject>`-typed adapter property doesn't deserialize a JSON array of objects correctly in this Quickshell version — `bars` is `property var` on the `JsonAdapter`, with defaults applied in QML instead of via a typed sub-object like the rest of this doc's `defaults` pattern.)

`bar.layout` (one bar's layout, i.e. one entry of `Settings.bars`) maps a screen name (as reported by Hyprland/Quickshell, e.g. `HDMI-1`, `DP-1`) to a set of sections (`left`, `center`, `right`), each an ordered array of **instance ids** — array order is display order, there's no separate `order` field. `default` is the layout used for any screen without its own entry. **A screen's own entry only overrides the sections it defines**: it falls back to `default` section-by-section, so e.g. defining `left` for `HDMI-1` still inherits `default`'s `center` if `HDMI-1` doesn't define one. A widget not listed in any section for a screen simply isn't shown there — there's no separate `enabled` flag.

### Instance ids vs widget types

A layout section never names a widget type directly — it names an **instance id**. An instance id is resolved to a widget type (a key in `widgets/Registry.qml`) via `widgets.<instanceId>.type`; if that's absent, the instance id doubles as the type id. This is what lets `clock_time` and `clock_date` both be `type: "clock"` with a different `format`, i.e. the same widget declared twice with different config — for a widget you only need once, skip `widgets` entirely and put the type id straight into the layout (e.g. plain `"clock"`).

`Settings.widgetType(instanceId)` resolves the type; `Settings.widgetConfig(instanceId, defaults)` merges that instance's config (minus `type`) over the type's defaults. `widgets` and `bar.layout` are both `property var`, not typed objects — **`Settings.qml` never needs to change when a widget is added**, which is what keeps the architecture plugin-friendly.

## Widget contract

A widget is a directory under `widgets/<name>/` with at minimum a `<Name>.qml` bar component (and a `<Name>Popup.qml` if it has one). To register it:

1. Add one line to `widgets/Registry.qml` mapping its type id to its `Component` and default config.
2. Reference that type id (or an instance id declared under `widgets` with a matching `type`) from a section in one of `settings.json`'s `bars[].layout` to actually show it.

No other file changes. Widget registration is a static declarative map, not a runtime dynamic loader — simpler and safer in QML than resolving component paths from strings at runtime.

`Bar.qml` reads `Settings.sectionWidgets(barConfig, sectionId, screenName)` for each of the three sections; for each instance id it resolves the type via `Settings.widgetType`, instantiates `Registry.definitions[type].component`, and sets `instanceId`, `screen`, **and `panelWindow`** on the loaded item — **every widget must expose settable `instanceId` (string), `screen` (the `ShellScreen` it's rendered on), and `panelWindow` (the `PanelWindow` it's rendered in) properties** (all three inherited for free by anything built on `ui/Pill.qml`) so it can look up its own config with `Settings.widgetConfig(instanceId, defaults)`, scope itself to its screen if relevant (e.g. Workspaces uses `Hyprland.monitorFor(screen)`), or open a native platform menu (needs an actual window, not just any QML `Item` — see Tray below). A widget that doesn't extend `Pill` must declare all three itself (see `widgets/workspaces/Workspaces.qml`, `widgets/tray/Tray.qml`).

## UI building blocks (`ui/`)

`ui/` holds generic, widget-agnostic pieces of chrome — not widgets themselves, nothing in there is registered or configured directly. `Pill.qml` and `Popup.qml` live here because they're meant to be reused by any future widget; if a new reusable building block (e.g. a slider, a toggle) comes up while building a widget, it belongs in `ui/`, not in that widget's own directory.

Not every widget fits `Pill` (a single clickable item — `clickable: false` makes it fully transparent, which only makes sense for a single interactive element, not a container). `widgets/workspaces/Workspaces.qml` needs a background *container* around several independently-clickable items, so it has its own root `Rectangle` and duplicates `Pill`'s small style-resolution snippet (`Settings.widgetStyle(instanceId, { background, radius })` → `Colors.resolve`) instead of extending it. Leave that duplicated until a third widget needs the same "styleable container, independently-clickable children" shape — then extract it into `ui/` (rule of three), not before.

## Widget styling

`ui/Pill.qml` resolves its own look from `widgets.<instanceId>.style`, so any widget built on it is styleable through settings.json with **no extra plumbing**:

```json
"widgets": {
  "clock_time": {
    "type": "clock",
    "style": { "background": "surface1", "hoverBackground": "accent", "radius": 8, "hoverDurationMs": 200 }
  }
}
```

`background`/`hoverBackground` accept either a `Colors` palette key (`"surface0"`, `"accent"`, ...) or a literal color string (`"#ff0000"`) — resolved by `Colors.resolve(token)`. `radius` and `hoverDurationMs` (the hover color transition) are plain numbers. Unset keys fall back to `Pill`'s built-in defaults (`Colors.surface0`/`surface1`, `Metrics.radiusMedium`, `120`ms).

`Pill` also exposes `clickable: bool` (default `true`), set by the widget itself from its own domain setting — not from `style` — since "is this interactive" is widget-specific (e.g. Clock's `showCalendar`). When `clickable` is `false`, the background goes fully transparent, hover/cursor are disabled, and clicks don't register: the widget reads as plain text, not a button. A widget with an optional popup should also bind the popup's `LazyLoader.loading` to the same condition, so a disabled popup is never even built.

This covers color/hover/radius today; extending it to more style knobs (e.g. font) means adding a key to `Pill`'s style defaults, not a new mechanism.

## Memory

- Popups always sit behind a `LazyLoader` — nothing builds until the widget is first clicked. **Remember to set `loading: true` on the `LazyLoader`** — without it, `item` stays `null` forever since nothing ever triggers the load (this bit us on the clock's calendar popup). For a lightweight popup (a few dozen items, e.g. the calendar grid), it's fine to just toggle `popupLoader.item.visible` afterwards and leave it resident — this is Quickshell's own documented pattern. Only tear down on close (bind `LazyLoader.active` to visibility instead) for a popup with genuinely heavy content (e.g. a long list rebuilt from a process output).
- On a `PopupWindow`-derived type, set `implicitWidth`/`implicitHeight`, not `width`/`height` — the latter is deprecated and logs a warning.
- Polling services (updates, sysmonitor) use a `refCount` property incremented/decremented by whichever widget instances are alive; their `Timer` only runs while `refCount > 0`. Do not add a free-running `Timer` to a service.
- Audio, tray, and Hyprland workspaces are push-based (Pipewire, SystemTray, `Quickshell.Hyprland`'s own event-socket listener) — no polling `Process`/`Timer` needed for those.
- A widget not referenced by any section for a screen is not instantiated there at all, not just hidden with `visible: false`.
- Instance pragmas (`//@ pragma ...` at the top of `shell.qml`, e.g. `UseQApplication`) only take effect on a full `quickshell` restart, never on hot reload — say so explicitly if a change needs one, don't just wait for the reload to "fix" it.

## Decisions from scoping (step 0)

- **Theme**: Catppuccin Macchiato, matching the current Hyprland theme (`config/hypr/themes/2024/macchiato.conf`).
- **Updates**: single `yay -Qu` call (covers repo + AUR); no separate `checkupdates` call.
- **Calendar**: month-view popup only, no external agenda/ICS integration.
- **Pomodoro**: in-memory state only, no disk persistence across Quickshell restarts.
- **Multi-screen**: each bar renders on every screen; per-screen `bar.layout` placement controls which widgets actually show where (see Settings above).
- **Multi-bar**: `settings.json`'s `bars` is a list — any number of independent bars (own id, position, height, layout) can coexist, e.g. a top status bar and a bottom dock-like bar.
- **Audio**: output + input (mic) + sink/source device picker, via `Quickshell.Services.Pipewire`.
- **Workspaces**: dynamic, not a fixed count — only workspaces that exist in `Hyprland.workspaces` are shown, scoped per-screen via `Hyprland.monitorFor(screen)`. Default Hyprland behavior destroys empty non-active workspaces (no `persistent` rule found in `config/hypr/`), so this already reflects "workspaces actually in use" rather than needing a separate persistence setting. No `services/Hyprland.qml` wrapper — `Quickshell.Hyprland`'s `Hyprland` singleton is already fully reactive with nothing to derive, a wrapper would add nothing.
- **Workspace focus indicator**: use `Hyprland.focusedWorkspace?.id === workspace.id`, not `workspace.focused` — the latter didn't update on a monitor-focus change in testing (only `activeworkspace`/keyboard-focus events reliably retarget `Hyprland.focusedWorkspace`; per-monitor `focused` can lag, matching the docs' note that some monitor-state changes don't emit an event at all). Each workspace cell in `Workspaces.qml` is its own fixed-size `Rectangle` (not just a `Text`) so the whole cell is clickable, not only the glyph — do this for any future multi-item widget, don't rely on a `Text`'s tight bounding box as a click target.
- **Tray**: `Quickshell.Services.SystemTray`'s `SystemTray.items` is global, not per-monitor (unlike workspaces) — `Tray.qml` shows the same icons on every bar/screen that includes it, no `Hyprland.monitorFor` filtering. Icons use `Quickshell.Widgets.IconImage`, not a plain `Image` — it resolves theme icon names, but a tray icon string can also come as `"<name>?path=<dir>"` (some tray implementations serve an icon from an arbitrary directory rather than the icon theme), which needs rewriting to a `file://` URL by hand — see `Tray.qml`'s `source` binding. A tray app can also hand out a broken/missing icon name (seen with `wayscriber-symbolic`, which doesn't exist in any installed theme). Diagnosed via `busctl --user get-property org.kde.StatusNotifierItem-<pid>-1 /StatusNotifierItem org.kde.StatusNotifierItem IconName|IconThemePath|IconPixmap`: `wayscriber` ships no icon file at all, only a raw `IconPixmap` (RGBA bytes over D-Bus) — the SNI-spec fallback for apps that skip installing an icon, which is why waybar (which reads `IconPixmap` itself) shows it fine. `Quickshell.Services.SystemTray`'s `SystemTrayItem` doesn't expose `IconPixmap` at all in its QML API — there's nothing to read even if we wanted to render it, this is a Quickshell limitation, not fixable from widget code without talking to D-Bus directly (judged not worth it for one app). Instead, `Tray.qml` shows a one-letter text fallback (first letter of the item's title/id) whenever `IconImage.status === Image.Error`, so a broken icon reads as a labeled placeholder instead of a blank gap.
- **Tray context menu (`display()`)**: needs two things that were missing initially. (1) `//@ pragma UseQApplication` at the top of `shell.qml` — native platform menus need Qt's `QApplication`, not the default `QGuiApplication`; this is an *instance* pragma, it only takes effect after a full `quickshell` restart, not a hot reload. (2) The item's own `Item.Window.window` attached property isn't a valid parent for `display()` (errors "must be called with a window") — use the injected `panelWindow` contract property instead, and map click coordinates to window space with `item.mapToItem(null, mouse.x, mouse.y)` since `display(parentWindow, x, y)` wants window-relative coordinates, not coordinates relative to the clicked icon. Left click → `activate()`, middle click → `secondaryActivate()`, right click → `item.display(root.panelWindow, pos.x, pos.y)` when `item.hasMenu`. Since switching to `QApplication`, a `QObject: Cannot create children for a parent that is in a different thread` warning shows up on every startup (from async `IconImage` loading crossing into the `QApplication` thread) — observed harmless so far, revisit if it ever causes an actual crash rather than just a log line.
