pragma Singleton

import QtQuick
import Quickshell
import qs.widgets.clock
import qs.widgets.workspaces
import qs.widgets.tray
import qs.widgets.audio
import qs.widgets.updates
import qs.widgets.sysmonitor
import qs.widgets.pomodoro
import qs.widgets.button
import qs.widgets.idleinhibitor
import qs.widgets.notifications
import qs.widgets.mpris

Singleton {
    id: root

    component Definition: QtObject {
        property var component
        property var defaults
    }

    readonly property var definitions: ({
        clock: clockDefinition,
        workspaces: workspacesDefinition,
        tray: trayDefinition,
        audio: audioDefinition,
        updates: updatesDefinition,
        sysmonitor: sysmonitorDefinition,
        pomodoro: pomodoroDefinition,
        button: buttonDefinition,
        idleinhibitor: idleInhibitorDefinition,
        notifications: notificationsDefinition,
        mpris: mprisDefinition
    })

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

    readonly property Definition pomodoroDefinition: Definition {
        component: pomodoroComponent
        defaults: ({})
    }

    readonly property Definition buttonDefinition: Definition {
        component: buttonComponent
        defaults: ({ label: "", onClick: "", onMiddleClick: "", onRightClick: "" })
    }

    readonly property Definition idleInhibitorDefinition: Definition {
        component: idleInhibitorComponent
        defaults: ({})
    }

    readonly property Definition notificationsDefinition: Definition {
        component: notificationsComponent
        defaults: ({})
    }

    readonly property Definition mprisDefinition: Definition {
        component: mprisComponent
        defaults: ({})
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

    Component {
        id: pomodoroComponent
        PomodoroIndicator {}
    }

    Component {
        id: buttonComponent
        Button {}
    }

    Component {
        id: idleInhibitorComponent
        IdleInhibitorIndicator {}
    }

    Component {
        id: notificationsComponent
        NotificationsIndicator {}
    }

    Component {
        id: mprisComponent
        MprisIndicator {}
    }
}
