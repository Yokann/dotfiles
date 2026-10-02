import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.config
import qs.theme
import qs.ui

// One Settings.panels entry, instantiated across every screen (same shape as
// modules/bar/Bar.qml for Settings.bars) - kept as its own file rather than
// folded into ui/Panel.qml so that reusable chrome stays named "Panel" as
// asked, without colliding with this per-config orchestrator's own type name.
Scope {
    id: root

    required property var panelConfig
    // Unlike a bar, a panel is an on-demand overlay - it starts hidden and is
    // toggled via IPC, not shown by default.
    property bool panelVisible: false

    IpcHandler {
        target: "panel-" + root.panelConfig.id

        function toggle(): void {
            root.panelVisible = !root.panelVisible;
        }

        function reveal(): void {
            root.panelVisible = true;
        }

        function hide(): void {
            root.panelVisible = false;
        }

        function isVisible(): bool {
            return root.panelVisible;
        }
    }

    Variants {
        model: Quickshell.screens

        Panel {
            id: panel

            required property var modelData

            screen: modelData
            position: root.panelConfig.position
            panelColor: Colors.resolve(root.panelConfig.background)
            columns: root.panelConfig.columns
            items: root.panelConfig.items
            widthSpec: root.panelConfig.width
            heightSpec: root.panelConfig.height

            // Shown only on the focused monitor, same reasoning as
            // SubmapIndicator - an on-demand overlay popping up on every
            // screen at once would be surprising, not useful.
            visible: root.panelVisible && Hyprland.monitorFor(modelData) === Hyprland.focusedMonitor

            // panelVisible (not panel.visible directly) stays the single source
            // of truth so this doesn't fight the visible binding above.
            onDismissRequested: root.panelVisible = false
        }
    }
}
