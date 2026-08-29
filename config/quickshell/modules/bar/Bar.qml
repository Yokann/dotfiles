import QtQuick
import Quickshell
import qs.config
import qs.theme
import qs.widgets

Scope {
    id: root

    required property var barConfig

    component WidgetLoader: Loader {
        required property string modelData

        sourceComponent: Registry.definitions[Settings.widgetType(modelData)]?.component ?? null
        onLoaded: {
            item.instanceId = modelData;
            item.screen = panel.modelData;
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData

            screen: modelData
            color: Colors.base
            implicitHeight: root.barConfig.height

            anchors {
                top: root.barConfig.position === "top"
                bottom: root.barConfig.position === "bottom"
                left: true
                right: true
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: Metrics.spacingMedium
                spacing: Metrics.spacingMedium

                Repeater {
                    model: Settings.sectionWidgets(root.barConfig, "left", panel.modelData.name)
                    delegate: WidgetLoader {}
                }
            }

            Row {
                anchors.centerIn: parent
                spacing: Metrics.spacingMedium

                Repeater {
                    model: Settings.sectionWidgets(root.barConfig, "center", panel.modelData.name)
                    delegate: WidgetLoader {}
                }
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: Metrics.spacingMedium
                spacing: Metrics.spacingMedium

                Repeater {
                    model: Settings.sectionWidgets(root.barConfig, "right", panel.modelData.name)
                    delegate: WidgetLoader {}
                }
            }
        }
    }
}
