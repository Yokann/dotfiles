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
        color: Audio.sinkMuted ? Colors.red : button.resolvedBackground

        onClicked: popupLoader.item.visible = !popupLoader.item.visible
        onRightClicked: Audio.toggleSinkMute()
        onScrolled: delta => Audio.setSinkVolume(Math.max(0, Math.min(1, Audio.sinkVolume + (delta > 0 ? 0.05 : -0.05))))

        Text {
            text: root.label
            color: Audio.sinkMuted ? Colors.crust : Colors.text
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
