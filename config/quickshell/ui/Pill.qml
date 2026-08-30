import QtQuick
import qs.config
import qs.theme

Rectangle {
    id: root

    default property alias content: contentRow.data
    property string instanceId: ""
    property var screen: null
    property var panelWindow: null
    property bool clickable: true
    // Exposed so a derived instance can layer its own state-driven color on top
    // of Pill's normal hover background (see widgets/idleinhibitor).
    readonly property alias hovered: mouseArea.containsMouse
    signal clicked()

    readonly property var style: Settings.widgetStyle(instanceId, {
            background: "surfaceBackground",
            hoverBackground: "hoverSurfaceBackground",
            radius: Metrics.radiusMedium,
            hoverDurationMs: 120,
            fontWeight: 600
    })

    implicitWidth: contentRow.implicitWidth + Metrics.spacingMedium * 2
    implicitHeight: contentRow.implicitHeight + Metrics.spacingSmall * 2
    radius: style.radius
    color: root.clickable ? (mouseArea.containsMouse ? Colors.resolve(style.hoverBackground) : Colors.resolve(style.background)) : "transparent"

    Behavior on color {
        ColorAnimation { duration: root.style.hoverDurationMs }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.clickable
        hoverEnabled: root.clickable
        cursorShape: root.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: root.clicked()
    }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: Metrics.spacingSmall
    }
}
