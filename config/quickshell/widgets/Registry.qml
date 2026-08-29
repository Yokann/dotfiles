pragma Singleton

import QtQuick
import Quickshell
import qs.widgets.placeholder
import qs.widgets.clock
import qs.widgets.workspaces
import qs.widgets.tray
import qs.widgets.audio
import qs.widgets.updates
import qs.widgets.sysmonitor

Singleton {
    id: root

    component Definition: QtObject {
        property var component
        property var defaults
    }

    readonly property var definitions: ({
        placeholder: placeholderDefinition,
        clock: clockDefinition,
        workspaces: workspacesDefinition,
        tray: trayDefinition,
        audio: audioDefinition,
        updates: updatesDefinition,
        sysmonitor: sysmonitorDefinition
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

    readonly property Definition trayDefinition: Definition {
        component: trayComponent
        defaults: ({})
    }

    readonly property Definition audioDefinition: Definition {
        component: audioComponent
        defaults: ({})
    }

    readonly property Definition updatesDefinition: Definition {
        component: updatesComponent
        defaults: ({})
    }

    readonly property Definition sysmonitorDefinition: Definition {
        component: sysmonitorComponent
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

    Component {
        id: trayComponent
        Tray {}
    }

    Component {
        id: audioComponent
        AudioIndicator {}
    }

    Component {
        id: updatesComponent
        UpdatesIndicator {}
    }

    Component {
        id: sysmonitorComponent
        SysmonitorIndicator {}
    }
}
