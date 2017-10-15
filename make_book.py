# -*- coding: utf-8 -*-

import os

exclude_list = ['template.md', 'credits.md']
rootDir = '.'
outfile = open('/tmp/output.md', 'w')
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
