import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

BarWidget {
    id: root

    readonly property string label: Updates.checking ? "…" : (Updates.count > 0 ? "↑" + Updates.count : "✓")

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    WidgetButton {
        id: button
        anchors.fill: parent
        idle: Updates.count === 0
        styleOverrides: root.resolveStyle({ idleBackground: "transparent" })

        onClicked: popupLoader.item.visible = !popupLoader.item.visible

        Text {
            text: root.label
            color: Updates.count > 0 ? Colors.yellow : Colors.text
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }

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
}
