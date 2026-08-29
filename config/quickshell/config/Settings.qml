pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // A JsonAdapter list<JsonObject> doesn't deserialize a JSON array of objects
    // correctly, so bars are plain objects merged over these defaults here instead.
    readonly property var bars: adapter.bars.map(bar => Object.assign({ id: "main", position: "top", height: 34, layout: {} }, bar))
    property alias widgets: adapter.widgets

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

    // Widget ids for one section of the given bar's layout, on one screen. A screen
    // falls back to "default" section-by-section: an entry only overrides the
    // sections it defines. Takes a single bar config (one entry of Settings.bars)
    // since there can be more than one bar.
    function sectionWidgets(bar: var, sectionId: string, screenName: string): var {
        const screenLayout = bar.layout[screenName] ?? {};
        const defaultLayout = bar.layout.default ?? {};
        return screenLayout[sectionId] ?? defaultLayout[sectionId] ?? [];
    }

    FileView {
        path: Quickshell.shellPath("settings.json")
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter

            property var bars: [{}]
            property var widgets: ({})
        }
    }
}
