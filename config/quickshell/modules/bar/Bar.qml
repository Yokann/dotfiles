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
            item.panelWindow = panel;
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData

            readonly property bool hasWidgets: Settings.sectionWidgets(root.barConfig, "left", modelData.name).length > 0
                || Settings.sectionWidgets(root.barConfig, "center", modelData.name).length > 0
                || Settings.sectionWidgets(root.barConfig, "right", modelData.name).length > 0
            readonly property string position: root.barConfig.position

            screen: modelData
            color: Colors.resolve(root.barConfig.background)
            implicitHeight: root.barConfig.height
            visible: hasWidgets

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
