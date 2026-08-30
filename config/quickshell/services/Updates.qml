pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int refCount: 0
    property bool checking: false
    property var packages: []
    readonly property int count: packages.length

    function poll(): void {
        if (root.checking)
            return;
        root.checking = true;
        checkProcess.running = true;
    }

    function runUpdate(): void {
        updateProcess.running = true;
    }

    Process {
        id: checkProcess
        command: ["yay", "-Qu"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.packages = text.trim().split("\n").filter(line => line.length > 0).map(line => {
                    const parts = line.split(" ");
                    return { name: parts[0], oldVersion: parts[1] ?? "", newVersion: parts[3] ?? "" };
                });
                root.checking = false;
            }
        }
    }

    Process {
        id: updateProcess
        command: ["footclient", "-H", "-T", "yay -Syu", "-e", "yay", "-Syu"]

        onExited: root.poll()
    }

    Timer {
        interval: 15 * 60 * 1000
        running: root.refCount > 0
        repeat: true
        triggeredOnStart: true
        onTriggered: root.poll()
    }
}
