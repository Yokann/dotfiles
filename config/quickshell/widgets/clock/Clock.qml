import QtQuick
import Quickshell
import qs.config
import qs.theme
import qs.ui

BarWidget {
    id: root

    readonly property var config: Settings.widgetConfig(instanceId, { format: "HH:mm", showCalendar: true })
    property string label: ""

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    WidgetButton {
        id: button
        anchors.fill: parent
        clickable: root.config.showCalendar
        styleOverrides: root.resolveStyle({})

        onClicked: popupLoader.item.visible = !popupLoader.item.visible

        Text {
            text: root.label
            color: Colors.text
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }

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
}
