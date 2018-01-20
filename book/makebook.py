# -*- coding: utf-8 -*-

# Author: @theDevilsVoice
#
# Date: April 4, 2017
#
# Script Name: makebook.py
#
# Description: Generates a markdown file of the cookbook
#
# Run Information:
#
# Error Log: Any output found in /path/to/logfile

import os

#exclude_list = ['template.md', 'credits.md']
exclude_list = ['template.md', 'book/README.md']
rootDir = '..'
if not os.path.exists('/tmp/cookbook'):
  os.makedirs('/tmp/cookbook')
outfile = open('/tmp/cookbook/output.md', 'w')
for dirName, subdirList, fileList in os.walk(rootDir):
  if ".git" in dirName.lower():
    continue
  #print('Found directory: %s' % dirName)
  for fname in fileList:
    if not fname in exclude_list and ".md" in fname:
      #print('Processing.... ' + dirName + '/' + fname)
      full_path = dirName + '/' + fname
      with open(full_path) as infile:
        for line in infile:
          outfile.write(line)
