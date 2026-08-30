import QtQuick
import Quickshell
import qs.theme

PopupWindow {
    id: root

    // No implicit sizing: set width/height explicitly on each instance. If content can be
    // taller than that fixed height, bind scrollContentHeight to its implicitHeight so it
    // scrolls instead of being clipped - defaults to 0 (no scrolling) otherwise.
    default property alias content: contentWrapper.data
    property real scrollContentHeight: 0
    color: "transparent"
    anchor.rect: Qt.rect(0, 0, anchor.item.width, anchor.item.height + Metrics.spacingLarge)

    Rectangle {
        anchors.fill: parent
        radius: Metrics.radiusLarge
        color: Colors.mantle
        border.color: Colors.surface0
        border.width: 1

        Flickable {
            id: flickable

            anchors.fill: parent
            anchors.margins: Metrics.spacingMedium
            anchors.rightMargin: Metrics.spacingMedium + Metrics.spacingSmall
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            contentWidth: width
            contentHeight: Math.max(height, root.scrollContentHeight)

            // Flickable needs exactly one plain, directly-nested child to scroll reliably -
            // the popup's actual content (via the "content" alias) goes inside this, rather
            // than being aliased straight into Flickable's own default property.
            Item {
                id: contentWrapper
                width: flickable.width
                height: flickable.contentHeight
            }
        }

        // Flickable's own wheel handling doesn't reliably reach this content inside a
        // Quickshell popup window; drive contentY from wheel events explicitly instead.
        // acceptedButtons: NoButton lets clicks/drags fall through to the Flickable and
        // its children below, only wheel is intercepted here. z: -1 keeps it behind the
        // Flickable's content so it doesn't shadow cursorShape set by nested MouseAreas.
        MouseArea {
            anchors.fill: flickable
            z: -1
            acceptedButtons: Qt.NoButton

            onWheel: event => {
                flickable.contentY = Math.max(0, Math.min(flickable.contentHeight - flickable.height, flickable.contentY - event.angleDelta.y / 2));
                event.accepted = true;
            }
        }

        Rectangle {
            id: scrollBar

            visible: flickable.contentHeight > flickable.height
            anchors.top: flickable.top
            anchors.right: parent.right
            anchors.rightMargin: Metrics.spacingSmall / 2
            anchors.topMargin: flickable.visibleArea.yPosition * flickable.height
            width: 3
            radius: 1.5
            color: Colors.overlay0
            height: flickable.visibleArea.heightRatio * flickable.height
        }
    }
}
