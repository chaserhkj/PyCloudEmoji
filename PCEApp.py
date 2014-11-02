#!/usr/bin/env python
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QUrl
import PCEModels
import PCEDataMgr
import os,sys
import json

class PCEApp(object):
    def __init__(self, app):
        self._engine = QQmlApplicationEngine()
        self._context = self._engine.rootContext()
        self._mgr = PCEDataMgr.DataMgr()
        self._repoM = PCEModels.RepoModel([])
        self._cateM = PCEModels.CateModel([])
        self._emojiM = PCEModels.EmojiModel([])
        self._cb = app.clipboard()

        self._context.setContextProperty("reposModel", self._repoM)
        self._context.setContextProperty("cateModel", self._cateM)
        self._context.setContextProperty("emojisModel", self._emojiM)

        self._engine.load(QUrl.fromLocalFile("interface.qml"))
        self._rootObj = self._engine.rootObjects()[0]

        self._rootObj.cateClicked.connect(self.updateEmoji)
        self._rootObj.emojiActivated.connect(self.copyEmoji)
        self._rootObj.addRepoRequested.connect(self.addRepo)
        self._rootObj.delRepoRequested.connect(self.delRepo)
        self._rootObj.aboutToClose.connect(self.saveAndCleanUp)
        
        self._seletedCate = -1

        self._config = os.path.join(os.environ["HOME"],".PCE.json")

        if os.path.exists(self._config):
            with open(self._config) as f:
                repoList = json.load(f)
            for i in repoList:
                self.addRepo(QUrl.fromLocalFile(i))
                
    def show(self):
        self._rootObj.show()

    def updateEmoji(self, row):
        self._seletedCate = row
        self._emojiM.setEmojis(self._mgr.emojis[row])

    def copyEmoji(self, row):
        self._cb.setText(self._mgr.emojis[self._seletedCate][row]["emoticon"])
        self._rootObj.minimize()

    def addRepo(self, url):
        self._mgr.addFile(url.toLocalFile())
        self._repoM.setRepos(self._mgr.repos)
        self._cateM.setCates(self._mgr.names)
        
    def delRepo(self, row):
        self._rootObj.warning("Not implemented!")

    def saveAndCleanUp(self):
        with open(self._config, "w") as f:
            json.dump([i[1] for i in self._mgr.repos], f, indent = 4)

if __name__=="__main__":
    app = QGuiApplication(sys.argv)
    PCE = PCEApp(app)
    PCE.show()
    sys.exit(app.exec_())
    

