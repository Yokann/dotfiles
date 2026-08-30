import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

BarWidget {
    id: root

    readonly property string label: Audio.sinkMuted ? " muted" : ` ${Math.round(Audio.sinkVolume * 100)}%`

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    WidgetButton {
        id: button
        anchors.fill: parent
        styleOverrides: root.resolveStyle({})

        onClicked: popupLoader.item.visible = !popupLoader.item.visible

        Text {
            text: root.label
            color: Colors.text
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }

        LazyLoader {
            id: popupLoader
            loading: true

            AudioPopup {
                anchor.item: root
            }
        }
    }
}
