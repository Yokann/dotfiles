import QtQuick
import qs.theme

Rectangle {
    id: root

    default property alias content: contentRow.data
    property string instanceId: ""
    signal clicked()

    implicitWidth: contentRow.implicitWidth + Metrics.spacingMedium * 2
    implicitHeight: contentRow.implicitHeight + Metrics.spacingSmall * 2
    radius: Metrics.radiusMedium
    color: mouseArea.containsMouse ? Colors.surface1 : Colors.surface0

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: Metrics.spacingSmall
    }
}
