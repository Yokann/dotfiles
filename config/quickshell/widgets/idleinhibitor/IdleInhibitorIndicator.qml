import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.theme
import qs.ui

BarWidget {
    id: root

    property bool inhibiting: false

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    WidgetButton {
        id: button
        anchors.fill: parent
        styleOverrides: root.resolveStyle({})
        color: root.inhibiting ? Colors.lavender : button.resolvedBackground

        onClicked: root.inhibiting = !root.inhibiting

        Text {
            text: root.inhibiting ? "" : "󰷛"
            color: root.inhibiting ? Colors.crust : button.resolvedTextColor
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }
    }

    IdleInhibitor {
        enabled: root.inhibiting
        window: root.panelWindow
    }
}
