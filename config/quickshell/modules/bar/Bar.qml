import QtQuick
import Quickshell
import qs.config
import qs.theme
import qs.widgets

Scope {
    property string barId: "main_bar"

    component WidgetLoader: Loader {
        required property string modelData

        sourceComponent: Registry.definitions[Settings.widgetType(modelData)]?.component ?? null
        onLoaded: item.instanceId = modelData
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData

            screen: modelData
            color: Colors.base
            implicitHeight: Settings.bar.height

            anchors {
                top: Settings.bar.position === "top"
                bottom: Settings.bar.position === "bottom"
                left: true
                right: true
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: Metrics.spacingMedium
                spacing: Metrics.spacingMedium

                Repeater {
                    model: Settings.sectionWidgets(barId, "left_section", panel.modelData.name)
                    delegate: WidgetLoader {}
                }
            }

            Row {
                anchors.centerIn: parent
                spacing: Metrics.spacingMedium

                Repeater {
                    model: Settings.sectionWidgets(barId, "center_section", panel.modelData.name)
                    delegate: WidgetLoader {}
                }
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: Metrics.spacingMedium
                spacing: Metrics.spacingMedium

                Repeater {
                    model: Settings.sectionWidgets(barId, "right_section", panel.modelData.name)
                    delegate: WidgetLoader {}
                }
            }
        }
    }
}
