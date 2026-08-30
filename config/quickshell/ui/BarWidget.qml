import QtQuick
import qs.config

Rectangle {
    id: root

    property string instanceId: ""
    property var screen: null
    property var panelWindow: null

    color: "transparent"

    function resolveStyle(defaults: var): var {
        return Settings.widgetStyle(instanceId, defaults);
    }
}
