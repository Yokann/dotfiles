import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.theme
import qs.services
import qs.ui

BarWidget {
    id: root

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    WidgetButton {
        id: button
        anchors.fill: parent
        styleOverrides: root.resolveStyle({
                background: "activeSurfaceBackground"
        })
        idle: Notifications.count === 0

        onClicked: togglePanelProcess.running = true
        onRightClicked: toggleDndProcess.running = true

        Text {
            text: Notifications.dnd ? ` ${Notifications.count}` : ` ${Notifications.count}`
            color: Colors.text
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }
    }

    Process { id: togglePanelProcess; command: ["swaync-client", "-t", "-sw"] }
    Process { id: toggleDndProcess; command: ["swaync-client", "-d", "-sw"] }
}
