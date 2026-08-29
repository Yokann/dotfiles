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

`settings.json` has a `bar` section and a `widgets` dictionary keyed by widget id:

```json
{
  "bar": { "position": "top", "height": 34 },
  "widgets": {
    "clock": { "enabled": true, "screens": "all", "order": 10 }
  }
}
```

`widgets` is exposed as `property var` on the `JsonAdapter`, not a typed object per widget. **`Settings.qml` never needs to change when a widget is added** — each widget reads its own slice (`Settings.widgets["clock"]`) and merges it with its own defaults. This is what keeps the architecture plugin-friendly.

`screens` accepts `"all"`, `"primary"`, or an explicit array of screen names — this is how a widget can be shown on one screen and hidden on another (e.g. tray/pomodoro/sysmonitor/updates on the primary screen only, clock/workspaces/audio everywhere).

## Widget contract

A widget is a directory under `widgets/<name>/` with at minimum a `<Name>.qml` bar component (and a `<Name>Popup.qml` if it has one). To register it:

1. Add one line to `widgets/Registry.qml` mapping its id to its `Component`.
2. Add its default entry to `settings.json` under `widgets`.

No other file changes. Widget registration is a static declarative map, not a runtime dynamic loader — simpler and safer in QML than resolving component paths from strings at runtime.

`Bar.qml` reads `Settings.widgets`, filters by `enabled` and by whether the current screen matches `screens`, sorts by `order`, and instantiates each via `Registry.definitions[id].component`.

## Memory

- Popups always sit behind a `LazyLoader` — built on first open, torn down on close. This is Quickshell's own recommendation for anything not shown immediately.
- Polling services (updates, sysmonitor) use a `refCount` property incremented/decremented by whichever widget instances are alive; their `Timer` only runs while `refCount > 0`. Do not add a free-running `Timer` to a service.
- Audio and tray are push-based (Pipewire, SystemTray) — no polling `Process`/`Timer` needed for those.
- A widget disabled or excluded from a screen via `screens` is not instantiated there at all, not just hidden with `visible: false`.

## Decisions from scoping (step 0)

- **Theme**: Catppuccin Macchiato, matching the current Hyprland theme (`config/hypr/themes/2024/macchiato.conf`).
- **Updates**: single `yay -Qu` call (covers repo + AUR); no separate `checkupdates` call.
- **Calendar**: month-view popup only, no external agenda/ICS integration.
- **Pomodoro**: in-memory state only, no disk persistence across Quickshell restarts.
- **Multi-screen**: bar renders on every screen; per-widget `screens` setting controls which screens actually show it.
- **Audio**: output + input (mic) + sink/source device picker, via `Quickshell.Services.Pipewire`.
