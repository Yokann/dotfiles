import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

BarWidget {
    id: root

    function usageColor(value: real): color {
        if (value > 90)
            return Colors.red;
        if (value > 75)
            return Colors.peach;
        return Colors.text;
    }

    function batteryColor(): color {
        if (Sysmonitor.batteryPercent < 5)
            return Colors.red;
        if (Sysmonitor.batteryPercent < 15)
            return Colors.peach;
        return Colors.text;
    }

    function batteryIcon(): string {
        const pct = Sysmonitor.batteryPercent;
        if (pct >= 100)
            return "󰁹";
        if (Sysmonitor.batteryCharging)
            return "󰂄";
        if (pct <= 5)
            return "󰂃";
        const tier = Math.max(10, Math.min(90, Math.round(pct / 10) * 10));
        return ({
            10: "󰁺", 20: "󰁻", 30: "󰁼", 40: "󰁽", 50: "󰁾",
            60: "󰁿", 70: "󰂀", 80: "󰂁", 90: "󰂂"
        })[tier];
    }

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    WidgetButton {
        id: button
        anchors.fill: parent
        styleOverrides: root.resolveStyle({})

        onClicked: popupLoader.item.visible = !popupLoader.item.visible

        Text {
            text: `󰻠 ${Math.round(Sysmonitor.cpuUsage)}%`
            color: root.usageColor(Sysmonitor.cpuUsage)
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }

        Text {
            text: ` 󰍛 ${Math.round(Sysmonitor.memUsage)}%`
            color: root.usageColor(Sysmonitor.memUsage)
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }

        Text {
            text: ` 󰋊 ${Math.round(Sysmonitor.diskUsage)}%`
            color: root.usageColor(Sysmonitor.diskUsage)
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }

        Text {
            id: batteryText
            visible: Sysmonitor.hasBattery
            text: ` ${root.batteryIcon()} ${Sysmonitor.batteryPercent}%`
            color: root.batteryColor()
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }

        SequentialAnimation {
            running: Sysmonitor.hasBattery && Sysmonitor.batteryPercent < 5
            loops: Animation.Infinite

            onRunningChanged: if (!running)
                batteryText.opacity = 1

            NumberAnimation {
                target: batteryText
                property: "opacity"
                to: 0.3
                duration: 600
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: batteryText
                property: "opacity"
                to: 1
                duration: 600
                easing.type: Easing.InOutQuad
            }
        }

        Component.onCompleted: Sysmonitor.refCount++
        Component.onDestruction: Sysmonitor.refCount--

        LazyLoader {
            id: popupLoader
            loading: true

            SysmonitorPopup {
                anchor.item: root
            }
        }
    }
}
