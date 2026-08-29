# Design notes

Quickshell 0.3 bar for Hyprland. Read this before adding or changing anything.

## Layout

```
shell.qml            ShellRoot, imports modules/bar
settings.json         user config, committed with sane defaults
config/
  Settings.qml         Singleton: FileView + JsonAdapter over settings.json
  BarSettings.qml       JsonObject: bar section (position, height)
theme/
  Colors.qml             Singleton: Catppuccin Macchiato palette
  Metrics.qml             Singleton: shared spacing/radius/font sizes
widgets/
  Registry.qml             Singleton: static id -> Component map
  common/                   shared chrome (Pill, PopupWindow)
  <name>/                   one self-contained widget per directory
modules/
  bar/Bar.qml               Variants over Quickshell.screens, one PanelWindow per screen
services/
  <Name>.qml                Singleton wrapping a system integration (added as needed per widget)
```

All internal imports use `import qs.<path>` (resolved relative to `shell.qml` by Quickshell itself — no manual `qmldir`).

## Settings

`settings.json` has a `bar` section, a `display` section (per-bar, per-screen widget placement), and a `widgets` dictionary keyed by widget id for widget-specific settings:

```json
{
  "bar": { "position": "top", "height": 34 },
  "display": {
    "main_bar": {
      "default": { "left_section": ["clock"] },
      "HDMI-1": { "left_section": ["clock", "pomodoro"] }
    }
  },
  "widgets": {
    "pomodoro": { "workMinutes": 25 }
  }
}
```

`display.<barId>` maps a screen name (as reported by Hyprland/Quickshell, e.g. `HDMI-1`, `DP-1`) to a set of sections (`left_section`, `center_section`, `right_section`), each an ordered array of widget ids — array order is display order, there's no separate `order` field. `default` is the layout used for any screen without its own entry. **A screen's own entry only overrides the sections it defines**: it falls back to `default` section-by-section, so e.g. defining `left_section` for `HDMI-1` still inherits `default`'s `center_section` if `HDMI-1` doesn't define one. A widget not listed in any section for a screen simply isn't shown there — there's no separate `enabled` flag.

`widgets` and `display` are both exposed as `property var` on the `JsonAdapter`, not typed objects. **`Settings.qml` never needs to change when a widget is added** — each widget reads its own slice (`Settings.widgets["clock"]`) and merges it with its own defaults via `Settings.widgetConfig(id, defaults)`. This is what keeps the architecture plugin-friendly.

## Widget contract

A widget is a directory under `widgets/<name>/` with at minimum a `<Name>.qml` bar component (and a `<Name>Popup.qml` if it has one). To register it:

1. Add one line to `widgets/Registry.qml` mapping its id to its `Component` (and, if it has widget-specific settings, their defaults).
2. Reference its id from a section in `settings.json`'s `display.main_bar` to actually show it.

No other file changes. Widget registration is a static declarative map, not a runtime dynamic loader — simpler and safer in QML than resolving component paths from strings at runtime.

`Bar.qml` reads `Settings.sectionWidgets(barId, sectionId, screenName)` for each of the three sections and instantiates each id via `Registry.definitions[id].component`.

## Memory

- Popups always sit behind a `LazyLoader` — nothing builds until the widget is first clicked. **Remember to set `loading: true` on the `LazyLoader`** — without it, `item` stays `null` forever since nothing ever triggers the load (this bit us on the clock's calendar popup). For a lightweight popup (a few dozen items, e.g. the calendar grid), it's fine to just toggle `popupLoader.item.visible` afterwards and leave it resident — this is Quickshell's own documented pattern. Only tear down on close (bind `LazyLoader.active` to visibility instead) for a popup with genuinely heavy content (e.g. a long list rebuilt from a process output).
- On a `PopupWindow`-derived type, set `implicitWidth`/`implicitHeight`, not `width`/`height` — the latter is deprecated and logs a warning.
- Polling services (updates, sysmonitor) use a `refCount` property incremented/decremented by whichever widget instances are alive; their `Timer` only runs while `refCount > 0`. Do not add a free-running `Timer` to a service.
- Audio and tray are push-based (Pipewire, SystemTray) — no polling `Process`/`Timer` needed for those.
- A widget not referenced by any section for a screen is not instantiated there at all, not just hidden with `visible: false`.

## Decisions from scoping (step 0)

- **Theme**: Catppuccin Macchiato, matching the current Hyprland theme (`config/hypr/themes/2024/macchiato.conf`).
- **Updates**: single `yay -Qu` call (covers repo + AUR); no separate `checkupdates` call.
- **Calendar**: month-view popup only, no external agenda/ICS integration.
- **Pomodoro**: in-memory state only, no disk persistence across Quickshell restarts.
- **Multi-screen**: bar renders on every screen; per-screen `display.main_bar` placement controls which widgets actually show where (see Settings above).
- **Audio**: output + input (mic) + sink/source device picker, via `Quickshell.Services.Pipewire`.
