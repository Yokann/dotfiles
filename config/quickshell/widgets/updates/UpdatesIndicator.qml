import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Pill {
    id: root

    readonly property string label: Updates.checking ? "…" : (Updates.count > 0 ? "↑" + Updates.count : "✓")

    color: root.hovered ? Colors.resolve(root.style.hoverBackground) : (Updates.count > 0 ? Colors.resolve(root.style.background) : Colors.transparent)

    Text {
        text: root.label
        color: Updates.count > 0 ? Colors.yellow : Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight
    }

    onClicked: popupLoader.item.visible = !popupLoader.item.visible

    Component.onCompleted: Updates.refCount++
    Component.onDestruction: Updates.refCount--

    LazyLoader {
        id: popupLoader
        loading: true

        UpdatesPopup {
            anchor.item: root
        }
    }
}
