import QtQuick
import qs.theme

Column {
    id: root

    // options: [{ label: string, value: var, isCurrent: bool }]
    property var options: []
    property string currentLabel: ""
    property bool expanded: false

    signal selected(var value)

    spacing: Metrics.spacingSmall / 2

    Rectangle {
        id: header

        width: parent.width
        implicitHeight: headerLabel.implicitHeight + Metrics.spacingSmall * 2
        radius: Metrics.radiusSmall
        color: headerMouse.containsMouse ? Colors.surface1 : Colors.surface0

        Behavior on color {
            ColorAnimation { duration: 120 }
        }

        Text {
            id: headerLabel
            anchors.left: parent.left
            anchors.right: arrow.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: Metrics.spacingSmall
            text: root.currentLabel
            color: Colors.text
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            elide: Text.ElideRight
        }

        Text {
            id: arrow
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: Metrics.spacingSmall
            text: root.expanded ? "▴" : "▾"
            color: Colors.subtext0
            font.pixelSize: Metrics.fontSize
        }

        MouseArea {
            id: headerMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.expanded = !root.expanded
        }
    }

    Column {
        width: parent.width
        visible: root.expanded
        spacing: Metrics.spacingSmall / 2

        Repeater {
            model: root.options

            delegate: Text {
                required property var modelData

                width: parent.width
                text: modelData.label
                color: modelData.isCurrent ? Colors.accent : Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize - 1
                elide: Text.ElideRight

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.selected(modelData.value);
                        root.expanded = false;
                    }
                }
            }
        }
    }
}
