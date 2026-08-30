import QtQuick
import Quickshell
import qs.theme
import qs.ui

Popup {
    id: root

    property date viewDate: new Date()

    readonly property var monthDays: {
        const year = viewDate.getFullYear();
        const month = viewDate.getMonth();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const firstWeekday = (new Date(year, month, 1).getDay() + 6) % 7;
        const today = new Date();

        const cells = [];
        for (let i = 0; i < firstWeekday; i++)
            cells.push(null);
        for (let day = 1; day <= daysInMonth; day++)
            cells.push({
                day: day,
                isToday: day === today.getDate() && month === today.getMonth() && year === today.getFullYear()
            });
        return cells;
    }

    implicitWidth: 240
    implicitHeight: 260
    visible: false
    grabFocus: true

    Column {
        anchors.fill: parent
        spacing: Metrics.spacingMedium

        Row {
            width: parent.width
            height: 24

            Text {
                width: 24
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "‹"
                color: Colors.text
                font.pixelSize: Metrics.fontSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.viewDate = new Date(root.viewDate.getFullYear(), root.viewDate.getMonth() - 1, 1)
                }
            }

            Text {
                width: parent.width - 48
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: root.viewDate.toLocaleDateString(Qt.locale(), "MMMM yyyy")
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
                font.bold: true
            }

            Text {
                width: 24
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "›"
                color: Colors.text
                font.pixelSize: Metrics.fontSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.viewDate = new Date(root.viewDate.getFullYear(), root.viewDate.getMonth() + 1, 1)
                }
            }
        }

        Grid {
            width: parent.width
            columns: 7
            columnSpacing: 2
            rowSpacing: 2

            Repeater {
                model: ["Lu", "Ma", "Me", "Je", "Ve", "Sa", "Di"]

                delegate: Text {
                    required property string modelData

                    width: (parent.width - 12) / 7
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData
                    color: Colors.subtext0
                    font.pixelSize: Metrics.fontSize - 2
                }
            }

            Repeater {
                model: root.monthDays

                delegate: Rectangle {
                    required property var modelData

                    width: (parent.width - 12) / 7
                    height: width
                    radius: Metrics.radiusSmall
                    color: modelData?.isToday ? Colors.accent : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: modelData ? modelData.day : ""
                        color: modelData?.isToday ? Colors.crust : Colors.text
                        font.pixelSize: Metrics.fontSize - 1
                    }
                }
            }
        }
    }
}
