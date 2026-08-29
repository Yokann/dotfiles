import QtQuick
import qs.theme

Item {
    id: root

    property real value: 0
    signal moved(real value)

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
        color: Colors.accent
    }

    MouseArea {
        anchors.fill: parent
        onPressed: mouse => root.moved(Math.max(0, Math.min(1, mouse.x / width)))
        onPositionChanged: mouse => {
            if (pressed)
                root.moved(Math.max(0, Math.min(1, mouse.x / width)));
        }
    }
}
