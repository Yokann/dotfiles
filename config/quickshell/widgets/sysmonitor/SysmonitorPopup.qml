import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Popup {
    id: root

    implicitWidth: 260
    implicitHeight: 120
    visible: false
    grabFocus: true

    anchor.edges: Edges.Bottom | Edges.Left
    anchor.margins.top: Metrics.spacingSmall

    Column {
        anchors.fill: parent
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
                fillColor: Sysmonitor.cpuUsage > 85 ? Colors.red : Colors.accent
            }
        }

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall / 2

            Text {
                text: `Mémoire — ${Math.round(Sysmonitor.memUsage)}%`
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
            }

            ProgressBar {
                width: parent.width
                value: Sysmonitor.memUsage / 100
                fillColor: Sysmonitor.memUsage > 85 ? Colors.red : Colors.accent
            }
        }

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall / 2

            Text {
                text: `Disque — ${Math.round(Sysmonitor.diskUsage)}%`
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
            }

            ProgressBar {
                width: parent.width
                value: Sysmonitor.diskUsage / 100
                fillColor: Sysmonitor.diskUsage > 85 ? Colors.red : Colors.accent
            }
        }
    }
}
