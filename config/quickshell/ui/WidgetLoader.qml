import QtQuick
import qs.config
import qs.widgets

// Resolves a widget instance id to its Registry component and wires up the
// instanceId/screen/panelWindow contract (see AGENT.md's Widget contract) -
// shared by any Repeater over a list of instance ids (modules/bar/Bar.qml's
// three sections, ui/Panel.qml's grid).
Loader {
    id: root

    required property string modelData
    property var screen: null
    property var panelWindow: null

    sourceComponent: Registry.definitions[Settings.widgetType(root.modelData)]?.component ?? null
    onLoaded: {
        item.instanceId = root.modelData;
        item.screen = root.screen;
        item.panelWindow = root.panelWindow;
    }
}
