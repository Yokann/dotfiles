import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.theme
import qs.ui

Pill {
    id: root

    property bool inhibiting: false

    color: root.inhibiting ? Colors.lavender : (root.hovered ? Colors.resolve(root.style.hoverBackground) : Colors.resolve(root.style.background))

    Text {
        text: root.inhibiting ? "" : "󰷛"
        color: root.inhibiting ? Colors.crust : Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight
    }

    onClicked: root.inhibiting = !root.inhibiting

    IdleInhibitor {
        enabled: root.inhibiting
        window: root.panelWindow
    }
}
