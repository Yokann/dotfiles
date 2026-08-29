pragma Singleton

import QtQuick
import Quickshell
import qs.widgets.placeholder
import qs.widgets.clock
import qs.widgets.workspaces

Singleton {
    id: root

    component Definition: QtObject {
        property var component
        property var defaults
    }

    readonly property var definitions: ({
        placeholder: placeholderDefinition,
        clock: clockDefinition,
        workspaces: workspacesDefinition
    })

    readonly property Definition placeholderDefinition: Definition {
        component: placeholderComponent
        defaults: ({})
    }

    readonly property Definition clockDefinition: Definition {
        component: clockComponent
        defaults: ({ format: "HH:mm" })
    }

    readonly property Definition workspacesDefinition: Definition {
        component: workspacesComponent
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

    Component {
        id: workspacesComponent
        Workspaces {}
    }
}
