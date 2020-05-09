# -*- coding: utf-8 -*-
"""
  hacker_cookbook application

  :copyright: (c) 2019 by @theDevilsVoice
  :license: CCC 1.0
"""
from flask import Flask, request, jsonify, render_template, redirect, render_template_string
import os
import json
from datetime import datetime

from flask_misaka import Misaka, markdown

app = Flask(__name__,  static_url_path='/static')
Misaka(app)

tree = {}
subfolders = {}

CURR_DIR = os.path.dirname(os.path.realpath(__file__))
content = ""
with open(CURR_DIR + '/templates/README.md', "r") as f:
  content = f.read()

def get_sections(path):
  subfolders = dict(name=path, children=[])
  try: lst = os.listdir(path)
  except OSError:
    pass #ignore errors
    # display 404
  else:
    for name in lst:
      fn = os.path.join(path, name)
      if os.path.isdir(fn):
        #subfolders['children'].append(get_sections(fn))
        subfolders['children'].append(name)
  #print ('DEBUG: ' + str(subfolders))
  return subfolders

@app.route('/')
def index():
  sections = get_sections('/app/hacker_cookbook/templates')
  return render_template("index.html", html=markdown(content), sections=sections)

def make_tree(path):
  tree = dict(name=path, children=[])
  try: lst = os.listdir(path)
  except OSError:
    pass #ignore errors
    # display 404
  else:
    for name in lst:
      if (name != 'README.md' and name != '_section.md'):
        fn = os.path.join(path, name)
        if os.path.isdir(fn):
          tree['children'].append(make_tree(fn))
        else:
          tree['children'].append(dict(name=fn))
  return tree
  
@app.route('/display/<section>/<recipe>')
def load_page(section, recipe):
  my_recipe = CURR_DIR + '/templates/' + section + '/' + recipe + '/' + recipe + '.md'
  my_content=""
  try:
    with open(my_recipe, "r") as f:
      my_content = f.read()
    sections = get_sections('/app/hacker_cookbook/templates')
    print ('DEBUG: ' + markdown(my_content))
    return render_template("index.html", html=markdown(my_content), sections=sections)
  except: 
    return render_template('404.html'), 404


@app.route('/<section>')
def list_recipes(section):
  sections = get_sections('/app/hacker_cookbook/templates')
  my_section = CURR_DIR + "/templates/" + section
  if os.path.isdir(my_section):
    tree = make_tree(my_section)
    return render_template("sub.html", section=section, tree=tree, sections=sections )
  else:
    return render_template('404.html'), 404
  
if __name__ == "__main__":
  app.run(host="0.0.0.0",debug=False)