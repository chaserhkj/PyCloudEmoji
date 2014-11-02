#!/usr/bin/env python
from PyQt5.QtCore import QAbstractTableModel,QAbstractListModel
from PyQt5.QtCore import QVariant
from PyQt5.QtCore import Qt

class EmojiModel(QAbstractTableModel):
    def __init__(self, emojis):
        self._emojis = [(i["description"], i["emoticon"]) for i in emojis]
        super(EmojiModel,self).__init__()
    def rowCount(self, index = None):
        return len(self._emojis)
    def columnCount(self, index = None):
        return 2
    def data(self, index, role = Qt.DisplayRole):
        if role == Qt.DisplayRole:
            return self._emojis[index.row()][index.column()]
        else:
            return QVariant()
    def setEmojis(self, emojis):
        self.beginResetModel()
        self._emojis = [(i["description"], i["emoticon"]) for i in emojis]
        self.endResetModel()

class CateModel(QAbstractListModel):
    def __init__(self, cates):
        self._cates = cates
        super(CateModel,self).__init__()
    def rowCount(self, index = None):
        return len(self._cates)
    def data(self, index, role = Qt.DisplayRole):
        if role == Qt.DisplayRole:
            return self._cates[index.row()]
        else:
            return QVariant()
    def setCates(self, cates):
        self.beginResetModel()
        self._cates = cates
        self.endResetModel()

class RepoModel(QAbstractTableModel):
    def __init__(self, repos):
        self._repos = repos
        super(RepoModel,self).__init__()
    def rowCount(self, index = None):
        return len(self._repos)
    def columnCount(self, index = None):
        return 2
    def data(self, index, role = Qt.DisplayRole):
        if role == Qt.DisplayRole:
            return self._repos[index.row()][index.column()]
        else:
            return QVariant()
    def setRepos(self, repos):
        self.beginResetModel()
        self._repos = repos
        self.endResetModel()
        
