import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.theme

Rectangle {
    id: root

    property string instanceId: ""
    property var screen: null
    property var panelWindow: null

    readonly property var config: Settings.widgetConfig(instanceId, {
        label: "",
        onClick: "",
        onMiddleClick: "",
        onRightClick: ""
    })

    readonly property var style: Settings.widgetStyle(instanceId, {
        background: "surface0",
        textColor: "text",
        hoverBackground: "surface1",
        hoverTextColor: "text",
        radius: Metrics.radiusMedium,
        hoverDurationMs: 120,
        fontWeight: Font.Normal
    })

    implicitWidth: label.implicitWidth + Metrics.spacingMedium * 2
    implicitHeight: label.implicitHeight + Metrics.spacingSmall * 2
    radius: root.style.radius
    color: Colors.resolve(mouseArea.containsMouse ? root.style.hoverBackground : root.style.background)

    Behavior on color {
        ColorAnimation { duration: root.style.hoverDurationMs }
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: root.config.label
        color: Colors.resolve(mouseArea.containsMouse ? root.style.hoverTextColor : root.style.textColor)
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight

        Behavior on color {
            ColorAnimation { duration: root.style.hoverDurationMs }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

        onClicked: mouse => {
            let command = "";
            let process = null;
            if (mouse.button === Qt.LeftButton) {
                command = root.config.onClick;
                process = leftProcess;
            } else if (mouse.button === Qt.MiddleButton) {
                command = root.config.onMiddleClick;
                process = middleProcess;
            } else if (mouse.button === Qt.RightButton) {
                command = root.config.onRightClick;
                process = rightProcess;
            }
            if (command) {
                process.command = ["sh", "-c", command];
                process.running = true;
            }
        }
    }

    Process { id: leftProcess }
    Process { id: middleProcess }
    Process { id: rightProcess }
}
