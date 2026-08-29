import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Pill {
    id: root

    Text {
        text: `󰻠 ${Math.round(Sysmonitor.cpuUsage)}%`
        color: Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight
    }

    Text {
        text: ` 󰍛 ${Math.round(Sysmonitor.memUsage)}%`
        color: Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight
    }

    Text {
        text: ` 󰋊 ${Math.round(Sysmonitor.diskUsage)}%`
        color: Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight
    }

    onClicked: popupLoader.item.visible = !popupLoader.item.visible

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
