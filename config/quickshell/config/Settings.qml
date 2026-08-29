pragma Singleton

import qs.config
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias bar: adapter.bar
    property alias widgets: adapter.widgets

    function widgetConfig(id: string, defaults: var): var {
        return Object.assign({}, defaults, root.widgets[id] ?? {});
    }

    function widgetVisibleOnScreen(id: string, defaults: var, screenName: string, isPrimary: bool): bool {
        const config = root.widgetConfig(id, defaults);
        if (!config.enabled)
            return false;

        const screens = config.screens ?? "all";
        if (screens === "all")
            return true;
        if (screens === "primary")
            return isPrimary;
        return Array.isArray(screens) && screens.includes(screenName);
    }

    FileView {
        path: Quickshell.shellPath("settings.json")
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter

            property BarSettings bar: BarSettings {}
            property var widgets: ({})
        }
    }
}
