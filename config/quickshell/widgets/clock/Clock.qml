import QtQuick
import Quickshell
import qs.config
import qs.theme
import qs.ui

Pill {
    id: root

    readonly property var config: Settings.widgetConfig(instanceId, { format: "HH:mm", showCalendar: true })
    property string label: ""

    clickable: config.showCalendar

    Text {
        text: root.label
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
        onTriggered: root.label = Qt.formatDateTime(new Date(), root.config.format)
    }

    LazyLoader {
        id: popupLoader
        loading: root.config.showCalendar

        CalendarPopup {
            anchor.item: root
        }
    }
}
