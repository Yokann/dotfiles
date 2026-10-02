import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.theme

// Reusable screen-anchored surface: attaches to an edge, a corner, or floats
// centered, and lays its content out as a grid of Registry-resolved widget
// components (same instanceId/screen/panelWindow contract as a bar's
// widgets, wired through ui/WidgetLoader.qml). Unlike ui/Popup.qml (anchored
// to a bar widget's rect), this anchors directly to the screen, so it's the
// right base for a standalone toggleable surface - see
// modules/panel/PanelInstance.qml for the settings.json-driven instantiation.
//
// The window itself always covers the whole screen (invisible outside the
// visible `content` rect below) so a background MouseArea can tell a genuine
// outside click apart from one landing on a hosted widget's own popup - those
// are separate windows entirely, so they never reach this MouseArea at all,
// unlike a compositor focus-grab (HyprlandFocusGrab), which cleared on any
// focus change and broke the instant a widget's own popup (e.g. AudioPopup's
// grabFocus: true) took its own grab. See Memory for the full story.
PanelWindow {
    id: root

    // "top" | "bottom" | "left" | "right" | "center" | "top-left" | "top-right" | "bottom-left" | "bottom-right".
    // An axis named by no edge centers `content` on that axis - see its anchors below.
    property string position: "top"
    property color panelColor: Colors.mantle
    property int columns: 3
    property var items: []
    property int edgeMargin: Metrics.spacingLarge
    // Each accepts a plain number (pixels) or a percentage string (e.g. "40%",
    // resolved against the screen's width/height) - see resolveSize below.
    property var widthSpec: 300
    property var heightSpec: 200

    readonly property var edges: root.position.split("-")

    // A percentage string is resolved against the screen dimension it sizes;
    // a plain number is already a pixel value and passes through untouched.
    function resolveSize(spec: var, screenSize: real): real {
        return typeof spec === "string" && spec.endsWith("%") ? screenSize * parseFloat(spec) / 100 : spec;
    }

    signal dismissRequested()

    color: "transparent"
    // A toggleable overlay shouldn't reserve layout space the way a bar does.
    exclusionMode: ExclusionMode.Ignore

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // Fills the whole screen so it can see a click anywhere outside `content`.
    // Declared before `content` so it sits underneath in the stacking order -
    // a click landing on `content` (or one of its buttons) is consumed there
    // and never reaches this MouseArea.
    MouseArea {
        anchors.fill: parent
        onClicked: root.dismissRequested()
    }

    Item {
        id: content

        width: root.resolveSize(root.widthSpec, root.screen?.width ?? 0)
        height: root.resolveSize(root.heightSpec, root.screen?.height ?? 0)

        // A bar's exclusive zone only shrinks the usable area for regular
        // (non-layer-shell) windows - it doesn't push other panel surfaces out
        // of the way, so a top/bottom-anchored panel must add the tallest
        // configured bar's height itself to avoid rendering underneath it.
        anchors {
            top: root.edges.includes("top") ? parent.top : undefined
            bottom: root.edges.includes("bottom") ? parent.bottom : undefined
            left: root.edges.includes("left") ? parent.left : undefined
            right: root.edges.includes("right") ? parent.right : undefined
            horizontalCenter: !root.edges.includes("left") && !root.edges.includes("right") ? parent.horizontalCenter : undefined
            verticalCenter: !root.edges.includes("top") && !root.edges.includes("bottom") ? parent.verticalCenter : undefined
            topMargin: root.edges.includes("top") ? Settings.barHeightAt("top") + root.edgeMargin : 0
            bottomMargin: root.edges.includes("bottom") ? Settings.barHeightAt("bottom") + root.edgeMargin : 0
            leftMargin: root.edges.includes("left") ? root.edgeMargin : 0
            rightMargin: root.edges.includes("right") ? root.edgeMargin : 0
        }

        PopupBackground {
            color: root.panelColor

            // A plain Grid only positions children at their natural size - it never
            // stretches them to fill a column/row, which is why the grid used to
            // leave empty space instead of spanning the panel's full width.
            // GridLayout does that stretching via Layout.fillWidth/fillHeight below.
            GridLayout {
                anchors.fill: parent
                anchors.margins: Metrics.spacingMedium
                columns: root.columns
                columnSpacing: Metrics.spacingMedium
                rowSpacing: Metrics.spacingMedium

                Repeater {
                    model: root.items
                    delegate: WidgetLoader {
                        screen: root.screen
                        panelWindow: root
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
