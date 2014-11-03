#!/usr/bin/env python
# Copyright (C) 2014 Chaserhkj
# This file is licensed under the MIT license
# For more details, see COPYRIGHT

from PyQt5.QtCore import QAbstractListModel
from PyQt5.QtCore import QVariant
from PyQt5.QtCore import Qt

class EmojiModel(QAbstractListModel):
    def __init__(self, emojis):
        self._emojis = [(i["description"], i["emoticon"]) for i in emojis]
        super(EmojiModel,self).__init__()
    def rowCount(self, index = None):
        return len(self._emojis)
    def data(self, index, role = 0):
        if role >= 0 and role < 2:
            return self._emojis[index.row()][role]
        else:
            return QVariant()
    def setEmojis(self, emojis):
        self.beginResetModel()
        self._emojis = [(i["description"], i["emoticon"]) for i in emojis]
        self.endResetModel()
    def roleNames(self):
        return {
            0:"name",
            1:"content"
        }

class CateModel(QAbstractListModel):
    def __init__(self, cates):
        self._cates = cates
        super(CateModel,self).__init__()
    def rowCount(self, index = None):
        return len(self._cates)
    def data(self, index, role = 0):
        if role == 0:
            return self._cates[index.row()]
        else:
            return QVariant()
    def setCates(self, cates):
        self.beginResetModel()
        self._cates = cates
        self.endResetModel()
    def roleNames(self):
        return {
            0:"name",
            1:"content"
        }

class RepoModel(QAbstractListModel):
    def __init__(self, repos):
        self._repos = repos
        super(RepoModel,self).__init__()
    def rowCount(self, index = None):
        return len(self._repos)
    def data(self, index, role = 0):
        if role >= 0 and role < 2:
            return self._repos[index.row()][role]
        else:
            return QVariant()
    def setRepos(self, repos):
        self.beginResetModel()
        self._repos = repos
        self.endResetModel()
    def roleNames(self):
        return {
            0:"name",
            1:"content"
        }
        
