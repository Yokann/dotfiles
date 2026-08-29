pragma Singleton

import qs.config
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias bar: adapter.bar
    property alias widgets: adapter.widgets
    property alias display: adapter.display

    function widgetConfig(id: string, defaults: var): var {
        return Object.assign({}, defaults, root.widgets[id] ?? {});
    }

    // Widget ids for one section of one bar, on one screen. A screen falls back to
    // "default" section-by-section: an entry only overrides the sections it defines.
    function sectionWidgets(barId: string, sectionId: string, screenName: string): var {
        const bar = root.display[barId] ?? {};
        const screenLayout = bar[screenName] ?? {};
        const defaultLayout = bar.default ?? {};
        return screenLayout[sectionId] ?? defaultLayout[sectionId] ?? [];
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
            property var display: ({})
        }
    }
}
