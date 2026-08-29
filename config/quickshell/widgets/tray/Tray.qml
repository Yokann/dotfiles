import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.config
import qs.theme

Row {
    id: root

    property string instanceId: ""
    property var screen: null
    property var panelWindow: null

    readonly property var style: Settings.widgetStyle(instanceId, {
        hoverBackground: "surface1",
        radius: Metrics.radiusSmall
    })

    spacing: Metrics.spacingSmall

    Repeater {
        model: SystemTray.items

        delegate: Rectangle {
            id: trayItem

            required property SystemTrayItem modelData

            width: Metrics.fontSize + Metrics.spacingMedium
            height: width
            radius: root.style.radius
            color: mouseArea.containsMouse ? Colors.resolve(root.style.hoverBackground) : "transparent"

            Behavior on color {
                ColorAnimation { duration: 120 }
            }

            IconImage {
                id: icon

                anchors.fill: parent
                anchors.margins: Metrics.spacingSmall / 2
                asynchronous: true
                visible: status !== Image.Error
                source: {
                    const icon = trayItem.modelData.icon;
                    if (icon.includes("?path=")) {
                        const [name, path] = icon.split("?path=");
                        return `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                    }
                    return icon;
                }
            }

            Text {
                // Some tray apps (e.g. wayscriber) ship no icon file at all, only a raw
                // IconPixmap over D-Bus — SystemTrayItem doesn't expose that, so this is
                // the best we can do without talking to D-Bus ourselves.
                visible: icon.status === Image.Error
                anchors.centerIn: parent
                text: (trayItem.modelData.title || trayItem.modelData.id || "?").charAt(0).toUpperCase()
                color: Colors.subtext0
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton)
                        trayItem.modelData.activate();
                    else if (mouse.button === Qt.MiddleButton)
                        trayItem.modelData.secondaryActivate();
                    else if (trayItem.modelData.hasMenu) {
                        const pos = trayItem.mapToItem(null, mouse.x, mouse.y);
                        trayItem.modelData.display(root.panelWindow, pos.x, pos.y);
                    }
                }
            }
        }
    }
}
