
import QtQuick 2.11
import QtQuick.Controls 2.4

Column {
    id: clock
    spacing: 0
    width: parent.width / 2

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 15
        font.bold: false
        color: "#000000"
        renderType: Text.QtRendering
        text: config.HeaderText
        anchors.top: parent.top
        anchors.topMargin: -5
    }

    Label {
        id: timeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: root.font.pointSize * 3
        anchors.verticalCenter: parent.verticalCenter
        color: "#e1e2e3"
        renderType: Text.QtRendering
        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(config.Locale), config.HourFormat == "long" ? Locale.LongFormat : config.HourFormat !== "" ? config.HourFormat : Locale.ShortFormat)
        }
       anchors.verticalCenterOffset: 2
    }

    Label {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
       anchors.verticalCenter: parent.verticalCenter
          color: "#e1e2e3"
font.bold: true
font.pointSize: 30
        renderType: Text.QtRendering
        function updateTime() {
            text = new Date().toLocaleDateString(Qt.locale(config.Locale), config.DateFormat == "short" ? Locale.ShortFormat : config.DateFormat !== "" ? config.DateFormat : Locale.LongFormat)
        }
 anchors.verticalCenterOffset: -60
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            dateLabel.updateTime()
            timeLabel.updateTime()
        }
    }

    Component.onCompleted: {
        dateLabel.updateTime()
        timeLabel.updateTime()
    }
}
