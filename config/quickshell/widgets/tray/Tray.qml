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

    // Sized off the actual rendered text height (not a raw font.pixelSize, which
    // undershoots real glyph ascent/descent) so tray squares match ui/Pill.qml's
    // implicitHeight exactly and sit vertically centered next to Pill-based
    // siblings in the same bar section - a plain `Metrics.fontSize + ...` here
    // came out a few px shorter and looked top-aligned instead.
    Text {
        id: heightReference
        visible: false
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
    }

    Repeater {
        model: SystemTray.items

        delegate: Rectangle {
            id: trayItem

            required property SystemTrayItem modelData

            // A tray app's SNI icon property can go transiently empty an empty
            // source leaves IconImage.status at Image.Null, not Image.Error, so it
            // must be treated as its own "no icon" case rather than folded into the
            // error check below, or the icon just goes blank with no fallback.
            readonly property string iconSource: {
                const iconName = trayItem.modelData.icon;
                if (!iconName)
                return "";
                if (iconName.includes("?path=")) {
                    const [name, path] = iconName.split("?path=");
                    return `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                }
                return iconName;
            }

            width: heightReference.implicitHeight + Metrics.spacingSmall * 2
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
                visible: trayItem.iconSource !== "" && status !== Image.Error
                source: trayItem.iconSource
            }

            Text {
                // Some tray apps (e.g. wayscriber) ship no icon file at all, only a raw
                // IconPixmap over D-Bus — SystemTrayItem doesn't expose that, so this is
                // the best we can do without talking to D-Bus ourselves.
                visible: trayItem.iconSource === "" || icon.status === Image.Error
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
