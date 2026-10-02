pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // A JsonAdapter list<JsonObject> doesn't deserialize a JSON array of objects
    // correctly, so bars are plain objects merged over these defaults here instead.
    readonly property var bars: adapter.bars.map(bar => Object.assign({ id: "main", position: "top", height: 34, background: "base", layout: {} }, bar))
    // Same list-of-plain-objects treatment as bars. Unlike bars, panels default to
    // an empty list - a panel is an opt-in overlay, not something every setup wants
    // one of by default.
    readonly property var panels: adapter.panels.map(panel => Object.assign({ id: "panel", position: "top", width: 300, height: 200, background: "mantle", columns: 3, items: [] }, panel))
    property alias widgets: adapter.widgets
    // Config for background modules (not tied to any bar, e.g. hyprland_submap) -
    // each module parses its own sub-object out of this dict itself, there's no
    // shared instance/type-resolution mechanism like bar widgets have.
    property alias modules: adapter.modules

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

    // Tallest configured bar anchored to the given edge ("top" or "bottom"), or 0
    // if none - lets a screen-anchored surface (e.g. ui/Panel.qml) avoid rendering
    // underneath it, since a bar's exclusive zone doesn't push other panels away.
    function barHeightAt(position: string): int {
        return root.bars.filter(bar => bar.position === position).reduce((max, bar) => Math.max(max, bar.height), 0);
    }

    FileView {
        path: Quickshell.shellPath("settings.json")
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter

            property var bars: [{}]
            property var panels: []
            property var widgets: ({})
            property var modules: ({})
        }
    }
}
