pragma Singleton

import QtQuick
import Quickshell
import qs.widgets.placeholder
import qs.widgets.clock

Singleton {
    id: root

    component Definition: QtObject {
        property var component
        property var defaults
    }

    readonly property var definitions: ({
        placeholder: placeholderDefinition,
        clock: clockDefinition
    })

    readonly property Definition placeholderDefinition: Definition {
        component: placeholderComponent
        defaults: ({})
    }

    readonly property Definition clockDefinition: Definition {
        component: clockComponent
        defaults: ({})
    }

    Component {
        id: placeholderComponent
        Placeholder {}
    }

    Component {
        id: clockComponent
        Clock {}
    }
}
