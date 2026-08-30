import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Popup {
    id: root

    function usageFillColor(value: real): color {
        if (value > 90)
            return Colors.red;
        if (value > 75)
            return Colors.peach;
        return Colors.accent;
    }

    function batteryFillColor(): color {
        if (Sysmonitor.batteryPercent < 5)
            return Colors.red;
        if (Sysmonitor.batteryPercent < 15)
            return Colors.peach;
        return Colors.accent;
    }

    implicitWidth: 260
    implicitHeight: contentColumn.implicitHeight + Metrics.spacingMedium * 2
    visible: false
    grabFocus: true

    anchor.edges: Edges.Bottom | Edges.Left
    anchor.margins.top: Metrics.spacingSmall

    Column {
        id: contentColumn
        width: parent.width
        spacing: Metrics.spacingMedium

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall / 2

            Text {
                text: `CPU — ${Math.round(Sysmonitor.cpuUsage)}%`
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
            }

            ProgressBar {
                width: parent.width
                value: Sysmonitor.cpuUsage / 100
                fillColor: root.usageFillColor(Sysmonitor.cpuUsage)
            }
        }

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall / 2

            Text {
                text: `Memory — ${Math.round(Sysmonitor.memUsage)}%`
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
            }

            ProgressBar {
                width: parent.width
                value: Sysmonitor.memUsage / 100
                fillColor: root.usageFillColor(Sysmonitor.memUsage)
            }
        }

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall / 2

            Text {
                text: `Disk — ${Math.round(Sysmonitor.diskUsage)}%`
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
            }

            ProgressBar {
                width: parent.width
                value: Sysmonitor.diskUsage / 100
                fillColor: root.usageFillColor(Sysmonitor.diskUsage)
            }
        }

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall / 2
            visible: Sysmonitor.hasBattery

            Text {
                text: `Battery — ${Sysmonitor.batteryPercent}%${Sysmonitor.batteryCharging ? " (charging)" : ""}`
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
            }

            ProgressBar {
                width: parent.width
                value: Sysmonitor.batteryPercent / 100
                fillColor: root.batteryFillColor()
            }
        }
    }
}
