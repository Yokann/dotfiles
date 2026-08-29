import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Pill {
    id: root

    readonly property string label: Audio.sinkMuted ? "muet" : `${Math.round(Audio.sinkVolume * 100)}%`

    Text {
        text: root.label
        color: Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight
    }

    onClicked: popupLoader.item.visible = !popupLoader.item.visible

    LazyLoader {
        id: popupLoader
        loading: true

        AudioPopup {
            anchor.item: root
        }
    }
}
