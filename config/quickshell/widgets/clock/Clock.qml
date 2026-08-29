import QtQuick
import Quickshell
import qs.theme
import qs.widgets.common

Pill {
    id: root

    property string time: ""

    Text {
        text: root.time
        color: Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
    }

    onClicked: popupLoader.item.visible = !popupLoader.item.visible

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.time = new Date().toLocaleTimeString(Qt.locale(), "HH:mm")
    }

    LazyLoader {
        id: popupLoader
        loading: true

        CalendarPopup {
            anchor.item: root
        }
    }
}
