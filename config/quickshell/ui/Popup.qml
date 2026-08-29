import QtQuick
import Quickshell
import qs.theme

PopupWindow {
    id: root

    // No implicit sizing: set width/height explicitly on each instance.
    default property alias content: contentItem.data
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: Metrics.radiusLarge
        color: Colors.mantle
        border.color: Colors.surface0
        border.width: 1

        Item {
            id: contentItem
            anchors.fill: parent
            anchors.margins: Metrics.spacingMedium
        }
    }
}
