import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.theme
import qs.services

Rectangle {
    id: root

    property string instanceId: ""
    property var screen: null
    property var panelWindow: null

    readonly property var style: Settings.widgetStyle(instanceId, {
            background: Notifications.count > 0 ? "activeSurfaceBackground" : "surfaceBackground",
            hoverBackground: "hoverSurfaceBackground",
            radius: Metrics.radiusMedium,
            hoverDurationMs: 120,
            fontWeight: Font.Normal
    })

    implicitWidth: label.implicitWidth + Metrics.spacingMedium * 2
    implicitHeight: label.implicitHeight + Metrics.spacingSmall * 2
    radius: root.style.radius
    color: mouseArea.containsMouse ? Colors.resolve(root.style.hoverBackground) : Colors.resolve(root.style.background)

    Behavior on color {
        ColorAnimation { duration: root.style.hoverDurationMs }
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: Notifications.dnd ? ` ${Notifications.count}` : ` ${Notifications.count}`
        color: Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton)
            togglePanelProcess.running = true;
            else if (mouse.button === Qt.RightButton)
            toggleDndProcess.running = true;
        }
    }

    Process { id: togglePanelProcess; command: ["swaync-client", "-t", "-sw"] }
    Process { id: toggleDndProcess; command: ["swaync-client", "-d", "-sw"] }
}
