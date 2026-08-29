pragma Singleton

import qs.config
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias bar: adapter.bar
    property alias widgets: adapter.widgets
    property alias display: adapter.display

    // Widget type ("clock", ...) backing an instance id. Defaults to the instance id
    // itself, so a single unconfigured instance needs no entry in `widgets` at all.
    function widgetType(instanceId: string): string {
        return root.widgets[instanceId]?.type ?? instanceId;
    }

    function widgetConfig(instanceId: string, defaults: var): var {
        const instanceConfig = Object.assign({}, root.widgets[instanceId] ?? {});
        delete instanceConfig.type;
        return Object.assign({}, defaults, instanceConfig);
    }

    // Same merge as widgetConfig, scoped to the instance's "style" sub-object.
    function widgetStyle(instanceId: string, defaults: var): var {
        const instanceStyle = root.widgets[instanceId]?.style ?? {};
        return Object.assign({}, defaults, instanceStyle);
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
