#!/usr/bin/env python
# Copyright (C) 2014 Chaserhkj
# This file is licensed under the MIT license
# For more details, see COPYRIGHT

import json
from lxml.etree import XML

class DataMgr(object):
    def __init__(self):
        self._repos = []
        self._cates = []
    @property
    def repos(self):
        return self._repos
    @property
    def cates(self):
        return self._cates
    @property
    def emojis(self):
        return [i["entries"] for i in self._cates]
    @property
    def names(self):
        return [i["name"] for i in self._cates]        
    def addJSONFile(self, path):
        with open(path) as f:
            data = json.load(f)
        name = data["information"][0]
        self._repos.append([name, path])
        self._cates.extend(data["categories"])
    def addXMLFile(self, path):
        with open(path, "rb") as f:
            tree = XML(f.read())
        name = tree.xpath("/emoji/infoos/info")[0].text
        self._repos.append([name, path])
        cates = []
        for i in tree.xpath("/emoji/category"):
            entries = []
            cate = i.attrib["name"]
            for j in i.xpath("entry"):
                desc = j.xpath("note")
                if not desc:
                    desc = ""
                else:
                    desc = desc[0].text
                content = j.xpath("string")
                content = content[0].text
                entries.append({
                    "description":desc,
                    "emoticon":content
                })
            cates.append({
                "entries":entries,
                "name":cate
            })
        self._cates.extend(cates)
    def addFile(self, path):
        if path.lower().endswith(".json"):
            self.addJSONFile(path)
        elif path.lower().endswith(".xml"):
            self.addXMLFile(path)
        else:
            raise(ValueError, "Can not determine file type from name.")
