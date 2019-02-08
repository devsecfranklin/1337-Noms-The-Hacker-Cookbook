# How To Generate the Cookbook

[![Build Status](https://travis-ci.org/DEAD10C5/1337-Noms-The-Hacker-Cookbook.svg?branch=master)](https://travis-ci.org/DEAD10C5/1337-Noms-The-Hacker-Cookbook)

## mdcheckr

https://github.com/mike42/mdcheckr

## Check Formatting

Install the markdown lint tool and clean up the MD files.

For example (from this directory):

```
echo "gem: --no-document" >> ~/.gemrc
gem install mdl
find .. -name '*.md' | xargs /var/lib/gems/2.3.0/gems/mdl-0.4.0/bin/mdl
```

Go through the output and address the formatting issues.

## Build the PDF File

* To omit MD files from the book, edit the exclude list in the file "book/makebook.py"
* Run the makebook.sh script to generate the PDF.
* The md2pdf tool is still python2

