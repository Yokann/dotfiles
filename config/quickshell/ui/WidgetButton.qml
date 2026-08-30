import QtQuick
import qs.theme

Rectangle {
    id: root

    default property alias content: contentRow.data

    readonly property var defaultStyle: ({
            background: "surfaceBackground",
            hoverBackground: "hoverSurfaceBackground",
            idleBackground: "surfaceBackground",
            idleTextColor: "text",
            inactiveBackground: "inactiveSurfaceBackground",
            inactiveTextColor: "text",
            textColor: "text",
            hoverTextColor: "text",
            radius: Metrics.radiusMedium,
            hoverDurationMs: 120,
            fontWeight: 600
    })

    // Whatever a composing widget passes in — may omit any key it doesn't care
    // about, since it's merged over defaultStyle below rather than replacing it.
    property var styleOverrides: ({})

    readonly property var style: Object.assign({}, root.defaultStyle, root.styleOverrides)

    property bool clickable: true
    property bool idle: false
    property bool inactive: false

    readonly property alias hovered: mouseArea.containsMouse

    readonly property color resolvedBackground: !root.clickable
    ? "transparent"
    : root.hovered ? Colors.resolve(root.style.hoverBackground)
    : root.idle ? Colors.resolve(root.style.idleBackground)
    : root.inactive ? Colors.resolve(root.style.inactiveBackground)
    : Colors.resolve(root.style.background)

    readonly property color resolvedTextColor: root.inactive ? Colors.resolve(root.style.inactiveTextColor)
    : root.hovered ? Colors.resolve(root.style.hoverTextColor)
    : root.idle ? Colors.resolve(root.style.idleTextColor)
    : Colors.resolve(root.style.textColor)

    signal clicked()
    signal middleClicked()
    signal rightClicked()
    signal scrolled(real delta)

    implicitWidth: contentRow.implicitWidth + Metrics.spacingMedium * 2
    implicitHeight: contentRow.implicitHeight + Metrics.spacingSmall * 2
    radius: root.style.radius
    color: root.resolvedBackground

    Behavior on color {
        ColorAnimation { duration: root.style.hoverDurationMs }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.clickable
        hoverEnabled: root.clickable
        cursorShape: root.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton)
            root.clicked();
            else if (mouse.button === Qt.MiddleButton)
            root.middleClicked();
            else if (mouse.button === Qt.RightButton)
            root.rightClicked();
        }
        onWheel: wheel => root.scrolled(wheel.angleDelta.y)
    }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: Metrics.spacingSmall
    }
}
