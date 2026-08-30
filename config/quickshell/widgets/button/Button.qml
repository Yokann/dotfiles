import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.theme
import qs.ui

BarWidget {
    id: root

    readonly property var config: Settings.widgetConfig(instanceId, {
            label: "",
            onClick: "",
            onMiddleClick: "",
            onRightClick: ""
    })

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    function run(command: string, process: var) {
        if (command) {
            process.command = ["sh", "-c", command];
            process.running = true;
        }
    }

    WidgetButton {
        id: button
        anchors.fill: parent
        styleOverrides: root.resolveStyle({
                background: "surfaceBackground",
                textColor: "text",
                hoverBackground: "hoverSurfaceBackground",
                hoverTextColor: "text",
                radius: Metrics.radiusMedium,
                hoverDurationMs: 120,
                fontWeight: Font.Normal
        })

        onClicked: root.run(root.config.onClick, leftProcess)
        onMiddleClicked: root.run(root.config.onMiddleClick, middleProcess)
        onRightClicked: root.run(root.config.onRightClick, rightProcess)

        Text {
            text: root.config.label
            color: button.resolvedTextColor
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight

            Behavior on color {
                ColorAnimation { duration: button.style.hoverDurationMs }
            }
        }
    }

    Process { id: leftProcess }
    Process { id: middleProcess }
    Process { id: rightProcess }
}
