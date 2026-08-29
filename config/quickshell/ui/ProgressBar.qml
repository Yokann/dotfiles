import QtQuick
import qs.theme

Item {
    id: root

    property real value: 0
    property color fillColor: Colors.accent

    implicitHeight: 6

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: Colors.surface1
    }

    Rectangle {
        width: parent.width * Math.max(0, Math.min(1, root.value))
        height: parent.height
        radius: height / 2
        color: root.fillColor

        Behavior on width {
            NumberAnimation { duration: 200 }
        }
    }
}
