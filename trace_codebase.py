#! /usr/bin/python3
"""Given the absolutepath to your target directory, this module can inventory all files within that
directory tree and color-code all launch, .h, and .cpp files in a collapsable treeview with
a janky little printout window for showing callback chains for any file you double click on.
"""
import os
import tkinter as tk
import ttk
from tkinter import Tk
import glob


__author__ = "Ryan Peters"
__version__ = "Day.One.Alpha..." # this shit's really unpolished, sorry


def get_directory_structure( rootdir:tuple)->dict:
    """
    Creates a nested dictionary that represents the folder structure of rootdir
    """
    dir_structure = dict()
    dir_structure["files"] = []
    dir_structure["dirs"] = dict()
    dir_structure["root"] = rootdir[0]
    with os.scandir(rootdir[1]) as it:
        for entry in it:
            pair = "".join([entry.name,", ",str(entry.path).replace("\\","/")])
            if entry.is_dir():
                dir_structure["dirs"][pair] = get_directory_structure(tuple(pair.split(", ")))
            else:
                dir_structure["files"].append(tuple(pair.split(", ")))
    return dir_structure


class DirectoryTreeViewer(tk.Frame):
    # ToDo: Comment this garbage fire of a file
    # ToDo: Implement checkboxes for quick expanding/collapsing to see user desired file types
    # ToDo: Finish implementing callback traces for file types other than .launch :P
    def __init__(self, parent, dir_dict:dict, tex):
        tk.Frame.__init__(self, parent)
        self.tex = tex
        self.parent = parent
        self.data = dir_dict
        self.launchers = dict()
        self.h = ".h"
        self.cpp = ".cpp"
        self.launch = "launch"
        self.py = ".py"
        self.tree = ttk.Treeview(self, columns=("directory","relative_path","absolute_paths",))
        self.vsb = ttk.Scrollbar(self, orient="vertical", command=self.tree.yview)
        self.tree.configure(yscrollcommand=self.vsb.set)
        
        self.vsb.pack(side="right", fill="y")
        self.tree.pack(side="top", fill="both", expand=True)
        self.init_building_tree(dir_dict)
                            # .h files are cyan (a blue-green color)
        self.color_map = {".h"    :("#0099ff",),
                          # .cpp files will be a nice bright yellow
                          '.cpp'  :"yellow",
                          # launch files are a fairly dark red
                          '.launch'     :"#aa0000",
                          # unit-tests for launch files are a slightly more pink color
                          'test_launch':"#993333",
                          # directories for launch files are more of a salmon color so as to appear
                          # more distinct from the files they contain
                          "dir_launch" :"#ff5555",
                          # python files are a nice dodger-blue
                          ".py"    :"#5555ff",
                          # Everything else that I have haven't gotten to yet is a darker charcoal
                          # gray color to help make the above files stand out more.
                          "other"    :"#555555",
                          "default" : "#3d3"}
        self.tree.tag_configure('.h', foreground="#0099ff")
        self.tree.tag_configure('.cpp', foreground="yellow")
        self.tree.tag_configure('.launch', foreground="#aa0000")
        self.tree.tag_configure('test_launch', foreground="#993333")
        self.tree.tag_configure("dir_launch", foreground="#ff5555")
        self.tree.tag_configure(".py", foreground="#5555ff")
        self.tree.tag_configure("other", foreground="#555555")
        self.tree.bind("<Double-1>", self.callback_tracer)
        self.expand_to_launch_files()
    
    def not_yet_implemented(self, item):
        color = self.tree.item(item, "tags")
        if color[0] in (".h", ".cpp", ".py"):
            self.tex["fg"] = self.color_map[color[0]]
            self.tex.insert(tk.END,
                            "\nSorry, we haven't implemented callback tracing for {} files yet...\n"
                            .format(color[0]))
            self.tex.see(tk.END)
            self.tex["fg"] = self.color_map["default"]
            
    def callback_tracer(self, event):
        item = self.tree.selection()[0]
        if not self.tree.tag_has("trace_launch_callbacks", item):
            self.not_yet_implemented(item)
            return
        path = self.tree.item(item,"values")[1]
        name = self.tree.item(item,"text")
        name_id_map = dict()
        caller_dict = dict()
        callable_dict = dict()
        name_id_map["callers"] = dict()
        name_id_map["callables"] = dict()
        for _name, _id in self.launchers.items():
            if _id == item:
                with open(path,"r+") as f:
                    for line in f.readlines():
                        if "include file" in line and ".launch\"":
                            # callables.add(other)
                            test_name = line[:line.rfind("\"")]
                            test_name = test_name[test_name.rfind("/")+1:]
                            callable_dict[test_name]= self.launchers[test_name]
            else:
                other_path = self.tree.item(_id,"values")[1]
                with open(other_path,"r+") as f:
                    for line in f.readlines():
                        if name in line:
                            if "include file" in line and name in line:
                                caller_dict[_name] = _id
        
        caller_string = "".join(["\t"+d+"\n" for d in caller_dict.keys()])
        callable_string = "".join(["\t"+d+"\n" for d in callable_dict.keys()])
        s = "{:~>50}\n{}\n{:~>50}\ngets called by:\n{}\ncan call:\n{}\n\n".format("~",name,"~",caller_string,callable_string)
        self.tex.insert(tk.END, s)
        self.tex.see(tk.END)  # Scroll if necessary
    
    def expand_to_launch_files(self):
        for name in self.launchers:
            parent = self.tree.parent(self.launchers[name])
            while parent:
                self.tree.item(parent, open=True)
                parent = self.tree.parent(parent)
    
    def init_building_tree(self, value:dict):
        _id = self.tree.insert("", -1, tex=value["root"])
        self.tree.item(_id, open=False)
        for key in value["dirs"]:
            name, path = key.split(", ")
            self.addNode(value=value['dirs'][key], relative_to_root=value["root"]+"/"+name, parentNode=_id, key=name)
        for name, path in value['files']:
            itm = self.tree.insert(_id, "end", values=(value["root"], path,), text=name)
            if self.h in name:
                self.tree.item(itm, tags=(".h", "<Double-1>"))
            elif self.cpp in name:
                self.tree.item(itm, tags=(".cpp", "<Double-1>"))
            elif self.launch in name:
                self.launchers[name] = itm
                self.tree.item(itm, tags=(".launch", "trace_launch_callbacks", "<Double-1>"))
            elif self.py in name:
                self.tree.item(itm, tags=(".py", "<Double-1>"))
            else:
                self.tree.item(itm, tags=("other",))
    
    def addNode(self, value, relative_to_root:str, parentNode="", key=None,start_tags=None):
        _id = self.tree.insert(parentNode, "end", text=key) if key else ""
        self.tree.item(_id, open=False, tags=(start_tags,))
        for key in value["dirs"]:
            name, path = key.split(", ")
            tags = "dir_launch" if "launch" in name else None
            self.addNode(value=value['dirs'][key], relative_to_root=relative_to_root+"/"+name, parentNode=_id, key=name, start_tags=tags)
        for name,path in value['files']:
            itm = self.tree.insert(_id,"end", values=(relative_to_root,path,),text=name)
            if self.h in name:
                self.tree.item(itm,tags=(".h","<Double-1>"))
            elif self.cpp in name:
                self.tree.item(itm,tags=(".cpp","<Double-1>"))
            elif self.launch in name:
                self.launchers[name] = itm
                if "test_" in name:
                    self.tree.item(itm,tags=("test_launch","trace_launch_callbacks","<Double-1>"))
                else:
                    self.tree.item(itm, tags=(".launch", "trace_launch_callbacks", "<Double-1>"))
            elif self.py in name:
                self.tree.item(itm, tags=(".py", "<Double-1>"))
            else:
                self.tree.item(itm, tags=("other",))


def cbc(id, tex):
    return lambda : callback(id, tex)

def callback(id, tex):
    s = 'At {} f is {}\n'.format(id, id**id/0.987)
    tex.insert(tk.END, s)
    tex.see(tk.END)             # Scroll if necessary


def globblog(target_name:str)->str:
    """Attempts to find an absolute path to the directory given by `target_name`
    
    """
    cwd = os.getcwd().replace("\\","/")
    print("current working directory is:\n\t{}".format(cwd))
    prefix = cwd[:cwd.rfind("/")+1]
    chosen_path = ""
    while prefix.count("/") > 0 and len(chosen_path)==0:
        try:
            pattern = prefix+"/"+target_name+"*"
            paths = glob.glob(pattern, recursive=True)
            prefix = prefix[:prefix.rfind("/")]
            chosen_path = os.path.abspath(paths.pop())
            while len(chosen_path)==0:
                chosen_path = os.path.abspath(paths.pop())
        except BaseException as be:
            # we didn't find a valid path this time
            continue
    return chosen_path

if __name__ == "__main__":
    abs_path = globblog("NasaRmc2018")
    proceed = \
        input("We've identified the following absolute path as the solution\n"
              "for finding the target directory:\n\t{}\n\nWould you like to use this path? [y]/n".format(abs_path))
    if proceed in ["y","Y","",None]:
        root_pair = "NasaRmc2018",abs_path
        nasa_dict = get_directory_structure(root_pair)
        color_legend = "{}Cyan denotes `*.h` files\n{}Red denotes `*.launch` files\n{}Green denotes `*.cpp` files{}"
        root = Tk()
        style = ttk.Style(root)
        style.theme_use('alt')
        tex = tk.Text(master=root)
        tex.config(width=200,height=20)
        tex.pack(side=tk.BOTTOM)
        tex.tag_add("initial", "1.0", "1.1")
        tex.tag_add("initial", "1.7", "1.8")
        tex.insert(tk.END,"Hello, and welcome to the alpha version of the codebase tracer!"
                   "\nPlease double click any launcher file (text in red) to see lists of what calls it, and what it calls...\n\n")
        # call the color-setting function manually the first time
        tex["bg"] = "#000"
        tex["fg"] = "#3d3"
        style.configure('Text', background="black", fieldbackground="black", foreground="green")
        style.configure('Treeview', background="black", fieldbackground="black", foreground="green")
        style.configure("Frame",background="black", fieldbackground="black", foreground="green")
        tree = DirectoryTreeViewer(root, nasa_dict, tex).pack(fill="both", expand=True)
        root.mainloop()
    else:
        print("You entered {}, so we're exiting ;)".format(proceed))
