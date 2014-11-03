// Copyright (C) 2014 Chaserhkj
// This file is licensed under the MIT license
// For more details, see COPYRIGHT
import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: window
    title: "PyCloudEmoji"
    width: 600
    minimumWidth: 200
    height: 500
    minimumHeight: 200

    signal cateClicked(int row)
    signal emojiActivated(int row)
    signal addRepoRequested(url file)
    signal delRepoRequested(int row)
    signal aboutToClose()

    property string copyright:{
    "PyCloudEmoji - A cloud solution to your favorite emoticons on Desktop.\n" +
    "Copyright (C) 2014 Chaserhkj\n" +
    "\n" +
    "Permission is hereby granted, free of charge, to any person obtaining a copy\n" +
    "of this software and associated documentation files (the \"Software\"), to deal\n" +
    "in the Software without restriction, including without limitation the rights\n" +
    "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n" +
    "copies of the Software, and to permit persons to whom the Software is\n" +
    "furnished to do so, subject to the following conditions:\n" +
    "\n" +
    "The above copyright notice and this permission notice shall be included in\n" +
    "all copies or substantial portions of the Software.\n" +
    "\n" +
    "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n" +
    "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n" +
    "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n" +
    "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n" +
    "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n" +
    "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n" +
    "THE SOFTWARE.\n"
    }
    
    onClosing: aboutToClose()
    
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

    function minimize() {
        window.visibility = Window.Minimized
    }

    Component {
        id: emojisTab
        RowLayout {
            id: rowLayout
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
                TableViewColumn {role: "name"; title: "Category"}
                model: cateModel
                onClicked: window.cateClicked(row)
            }
            TableView {
                id: emojis
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width /4 *3
                TableViewColumn {role: "name"; title: "Description"; width:100}
                TableViewColumn {role: "content"; title: "Emoticon"}
                model: emojisModel
                onActivated: window.emojiActivated(row)
            }

        }

    }


    Component {
        id: reposTab
        ColumnLayout {
            id: columnLayout
            anchors.fill: parent
            anchors.topMargin: 10
            anchors.leftMargin: 10
            anchors.rightMargin:  10
            anchors.bottomMargin:  10
            RowLayout {
                id: btnRowLayout
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Layout.alignment: Qt.AlignHCenter
                spacing: 50
                Button {
                    id: addBtn
                    Layout.fillWidth: true
                    Layout.maximumWidth: 100
                    text: "Add"
                    onClicked: addRepo.open()
                }
                Button {
                    id: delBtn
                    Layout.fillWidth: true
                    Layout.maximumWidth: 100
                    text: "Delete"
                    onClicked: {
                        if (repos.selected == -1) {
                            window.warning("No repo selected to delete.")
                        } else {
                            confirmDelete.open()
                        }
                    }
                }
            }
            TableView {
                id: repos
                property int selected: -1
                onClicked: selected = row
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: parent.height - btnRowLayout.height
                anchors.bottom: parent.bottom
                TableViewColumn {role: "name"; title: "Repo Name"; width:100}
                TableViewColumn {role: "content"; title: "File Path"}
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
                    onYes: window.delRepoRequested(repos.selected)
                }
                model: reposModel
            }
        }

    }

    Component {
        id: aboutTab
        TextArea {
            id: about
            readOnly: true
            text: window.copyright
            anchors.fill: parent
            anchors.topMargin: 20
            anchors.bottomMargin: 20
            anchors.leftMargin: 20
            anchors.rightMargin:  20

        }

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
            sourceComponent: emojisTab
        }
        Tab {
            title: "Repos"
            sourceComponent: reposTab
        }
        Tab {
            title: "About"
            sourceComponent: aboutTab
        }            
    }

}

    
