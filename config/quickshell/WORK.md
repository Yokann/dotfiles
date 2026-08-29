# Roadmap

Custom Quickshell bar for Hyprland. Each step ships one reviewable, self-contained unit.

- [x] **0 — Scoping.** Constraints and decisions, see `AGENT.md`.
- [x] **1 — Scaffolding.** Directory layout, `Settings`/`Colors`/`Metrics` singletons, widget `Registry`, `Bar.qml`, one placeholder widget end-to-end.
- [ ] **2 — Clock.** Bar clock + monthly calendar popup.
- [ ] **3 — Workspaces.** Hyprland workspaces widget (`Quickshell.Hyprland`).
- [ ] **4 — Tray.** System tray widget (`Quickshell.Services.SystemTray`).
- [ ] **5 — Audio.** Pipewire service (sink/source, volume, mute, device picker) + widget + popup.
- [ ] **6 — Updates.** `yay -Qu` polling service + widget + popup with pending package list.
- [ ] **7 — System monitor.** CPU/memory/disk polling service + widget.
- [ ] **8 — Pomodoro.** In-memory timer state machine + widget + controls popup.
- [ ] **9 — Polish.** Visual consistency pass, memory footprint check, remove the placeholder widget.

Steps 2-8 each add: a service (if needed), a bar component, a popup (if applicable), and a `settings.json` entry — reviewable independently of the others.
