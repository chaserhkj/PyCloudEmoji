import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: window
    title: "PyCloudEmoji"
    width: 400
    minimumWidth: 200
    height: 400
    minimumHeight: 200

    TabView {
        id: tabView
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin:  10               
        anchors.bottomMargin:  10
        Tab {
            title: "Emojis"
            RowLayout {
                anchors.topMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin:  10
                anchors.bottomMargin:  10
                spacing: 10
                anchors.fill: parent
                TableView {
                    id: repos
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width /4
                    TableViewColumn {role: "name"; title: "Name"}
                    model: ListModel {
                        id: reposModel
                    }
                }
                TableView {
                    id: emojis
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width /4 *3
                    TableViewColumn {role: "name"; title: "Name"; width:100}
                    TableViewColumn {role: "content"; title: "Content"}
                    model: ListModel {
                        id: emojisModel
                    }
                }

            }
        }
        Tab {
            title: "Repos"
            ColumnLayout {
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin:  10               
                anchors.bottomMargin:  10            
                RowLayout {
                    id: btnRow
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 50
                    Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 100
                        text: "Add"
                    }
                    Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 100
                        text: "Delete"
                    }
                }
                TableView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: parent.height - btnRow.height
                    anchors.bottom: parent.bottom
                    TableViewColumn {role: "name"; title: "Name"; width:100}
                    TableViewColumn {role: "path"; title: "File Path"}
                }
            }
        }
        Tab {
            title: "About"
            TextArea {
                readOnly: true
                text: "Author: Chaserhkj"
                anchors.fill: parent
                anchors.topMargin: 20
                anchors.bottomMargin: 20
                anchors.leftMargin: 20
                anchors.rightMargin:  20               

            } 
            
        }            
    }
}
