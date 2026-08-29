import QtQuick
import Quickshell
import qs.config
import qs.theme
import qs.widgets

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData
            readonly property bool isPrimary: modelData === Quickshell.screens[0]

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
                    model: {
                        const ids = Object.keys(Registry.definitions);
                        return ids.filter(id => Settings.widgetVisibleOnScreen(id, Registry.definitions[id].defaults, modelData.name, panel.isPrimary)).sort((a, b) => Settings.widgetConfig(a, Registry.definitions[a].defaults).order - Settings.widgetConfig(b, Registry.definitions[b].defaults).order);
                    }

                    delegate: Loader {
                        required property string modelData
                        sourceComponent: Registry.definitions[modelData].component
                    }
                }
            }
        }
    }
}
