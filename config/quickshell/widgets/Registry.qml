pragma Singleton

import QtQuick
import Quickshell
import qs.widgets.placeholder

Singleton {
    id: root

    component Definition: QtObject {
        property var component
        property var defaults
    }

    readonly property var definitions: ({
        placeholder: placeholderDefinition
    })

    readonly property Definition placeholderDefinition: Definition {
        component: placeholderComponent
        defaults: ({
            enabled: true,
            screens: "all",
            order: 0
        })
    }

    Component {
        id: placeholderComponent
        Placeholder {}
    }
}
