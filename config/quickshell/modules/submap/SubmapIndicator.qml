import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config
import qs.theme
import qs.ui

// Background module (not tied to any bar): a top-centered HUD that appears while
// a non-default Hyprland keybind submap is active, on whichever monitor is
// currently focused.
// A submap without its own entry falls back to displaying its raw name.
Scope {
    id: root

    // Hyprland exposes no readable "current submap" property - the only way to
    // track it is the "submap>>NAME" event on the raw IPC event stream (empty
    // NAME means the default/global submap, i.e. "no submap active").
    property string currentSubmap: ""
    readonly property string content: {
        if (root.currentSubmap === "")
            return "";
        const config = Settings.modules.hyprland_submap ?? {};
        return config[root.currentSubmap]?.content ?? root.currentSubmap;
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "submap")
                root.currentSubmap = event.data;
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData

            screen: modelData
            color: "transparent"
            focusable: false
            // Doesn't reserve space in the layout
            exclusionMode: ExclusionMode.Ignore
            visible: root.content !== "" && Hyprland.monitorFor(modelData) === Hyprland.focusedMonitor

            anchors.top: true
            margins.top: Settings.bars[0]?.height ?? 60

            implicitWidth: label.implicitWidth + Metrics.spacingLarge * 2
            implicitHeight: label.implicitHeight + Metrics.spacingMedium * 2

            PopupBackground {
                color: Colors.red
                Text {
                    id: label
                    anchors.centerIn: parent
                    text: root.content
                    color: Colors.contrastText
                    font.family: Metrics.fontFamily
                    font.pixelSize: Metrics.fontSize
                }
            }
        }
    }
}
