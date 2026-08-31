import QtQuick
import qs.theme

// Rounded chrome shared by every popup-style surface (a floating panel over the
// desktop): mantle background, subtle border, standard radius. Anchors to fill
// its parent - drop this straight inside any Window-ish Item and pass content as
// default-property children, e.g. `ui/Popup.qml` (a PopupWindow anchored to a
// bar widget) and `modules/submap/SubmapIndicator.qml` (a screen-anchored
// PanelWindow) both compose it rather than hand-rolling the same Rectangle.
Rectangle {
    default property alias content: contentItem.data

    anchors.fill: parent
    radius: Metrics.radiusLarge
    color: Colors.mantle
    border.color: Colors.surface0
    border.width: 1

    Item {
        id: contentItem
        anchors.fill: parent
    }
}
