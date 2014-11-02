import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: window
    title: "PyCloudEmoji"
    width: 400
    minimumWidth: 200
    height: 400
    minimumHeight: 200

    signal cateClicked(int row)
    signal emojiActivated(int row)
    signal addRepoRequested(url file)
    signal delRepoRequested(int row)

    MessageDialog {
        id: box
        title: "<title>"
        text: "<text>"
        icon: StandardIcon.Information
        modality: Qt.WindowModal
        standardButtons: StandardButton.Ok
    }

    function warning(text) {
        box.title = "Warning"
        box.text = text
        box.icon = StandardIcon.Warning
        box.open()
    }

    function info(text) {
        box.title = "Information"
        box.text = text
        box.icon = StandardIcon.Information
        box.open()
    }

    
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
                    id: cate
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width /4
                    TableViewColumn {role: "name"; title: "Name"}
                    model: cateModel
                    onClicked: window.cateClicked(row)
                }
                TableView {
                    id: emojis
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width /4 *3
                    TableViewColumn {role: "name"; title: "Name"; width:100}
                    TableViewColumn {role: "content"; title: "Content"}
                    model: emojisModel
                    onActivated: window.emojiActivated(row)
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
                        onClicked: addRepo.open()
                    }
                    Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 100
                        text: "Delete"
                        onClicked: {
                            if (repos.currentItem == null) {
                                window.warning("No repo selected to delete.")
                            } else {
                                confirmDelete.open()
                            }
                        }
                    }
                }
                TableView {
                    id: repos
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: parent.height - btnRow.height
                    anchors.bottom: parent.bottom
                    TableViewColumn {role: "name"; title: "Name"; width:100}
                    TableViewColumn {role: "path"; title: "File Path"}
                    FileDialog {
                        id: addRepo
                        title: "Please choose a repo file to add."
                        nameFilters: ["JSON repo file (*.json)", "XML repo file (*.xml)", "All files (*.*)"]
                        modality: Qt.WindowModal
                        selectExisting: true
                        onAccepted: window.addRepoRequested(fileUrl)
                    }
                    MessageDialog {
                        id: confirmDelete
                        title: "Confirm of deletion"
                        text: "Are you sure to delete this repo from the list?\nThe actual file will not be deleted."
                        icon: StandardIcon.Question
                        modality: Qt.WindowModal
                        standardButtons: StandardButton.Yes | StandardButton.No
                        onAccepted: window.delRepoRequested(repos.currentIndex)
                    }
                    model: reposModel
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

    
