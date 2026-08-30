import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config
import qs.theme

Rectangle {
    id: root

    property string instanceId: ""
    property var screen: null
    property var panelWindow: null

    readonly property var monitor: root.screen ? Hyprland.monitorFor(root.screen) : null
    readonly property var workspaceList: Hyprland.workspaces.values.filter(ws => ws.monitor === root.monitor).sort((a, b) => a.id - b.id)

    readonly property var style: Settings.widgetStyle(instanceId, {
            // background: "surface0",
            background: "surfaceBackground",
            radius: Metrics.radiusLarge,
            focusedBackground: "#eba6e0",
            focusedColor: "crust",
            activeColor: "subtext0",
            occupiedColor: "text",
            idleColor: "blue"
    })

    implicitWidth: row.implicitWidth + Metrics.spacingMedium * 2
    implicitHeight: row.implicitHeight + Metrics.spacingSmall * 2
    radius: style.radius
    color: Colors.resolve(style.background)

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Metrics.spacingSmall

        Repeater {
            model: root.workspaceList

            delegate: Rectangle {
                id: cell

                required property var modelData
                readonly property bool occupied: modelData.toplevels.values.length > 0
                // modelData.focused can lag behind actual monitor focus changes (Hyprland
                // doesn't always emit an event for those); Hyprland.focusedWorkspace tracks
                // the "focusedmon"/"workspace" events directly and stays accurate.
                readonly property bool focused: Hyprland.focusedWorkspace?.id === modelData.id

                implicitWidth: Math.max(label.implicitWidth + Metrics.spacingSmall * 2, implicitHeight)
                implicitHeight: Metrics.fontSize + Metrics.spacingSmall * 2
                radius: Metrics.radiusLarge
                color: cell.focused ? Colors.resolve(root.style.focusedBackground) : "transparent"

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }

                Text {
                    id: label
                    anchors.centerIn: parent
                    text: modelData.name || modelData.id
                    color: cell.focused ? Colors.resolve(root.style.focusedColor) : cell.modelData.active ? Colors.resolve(root.style.activeColor) : (cell.occupied ? Colors.resolve(root.style.occupiedColor) : Colors.resolve(root.style.idleColor))
                    font.family: Metrics.fontFamily
                    font.pixelSize: Metrics.fontSize
                    font.bold: cell.modelData.active
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: cell.modelData.activate()
                }
            }
        }
    }
}
