import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.theme

Item {
    id: root

    property string appId: ""
    property string fallbackText: appId
    property int size: Metrics.iconSize

    implicitWidth: size
    implicitHeight: size

    // A Wayland appId often doesn't exactly match its .desktop file id (case,
    // reverse-DNS prefix, etc.) - heuristicLookup handles that fuzzy matching.
    // Some apps' icon-theme name equals their appId directly, so that's tried
    // too when there's no matching desktop entry (or it has no icon set).
    // Each candidate is checked with hasThemeIcon first - iconPath's own
    // "fallback" argument is another icon *name* to try, not an empty-on-miss
    // sentinel, so passing "" there resolved to a theme's generic broken-icon
    // pixmap instead of really coming back empty.
    readonly property string resolvedIconName: {
        if (!root.appId)
        return "";
        const entry = DesktopEntries.heuristicLookup(root.appId);
        const candidates = [entry?.icon, root.appId].filter(name => !!name);
        return candidates.find(name => name.startsWith("/") || Quickshell.hasThemeIcon(name)) || "";
    }
    readonly property string iconSource: root.resolvedIconName ? Quickshell.iconPath(root.resolvedIconName) : ""

    IconImage {
        id: icon
        anchors.fill: parent
        asynchronous: true
        visible: root.iconSource !== "" && status !== Image.Error
        source: root.iconSource
    }

    Text {
        // Mirrors Tray.qml's fallback: an empty source leaves IconImage.status at
        // Image.Null, not Image.Error, so both cases need checking here too.
        visible: root.iconSource === "" || icon.status === Image.Error
        anchors.centerIn: parent
        text: (root.fallbackText || "?").charAt(0).toUpperCase()
        color: Colors.text
        font.family: Metrics.fontFamily
        font.pixelSize: Math.min(root.size, Metrics.fontSize)
    }
}
