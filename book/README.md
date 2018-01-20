# How To Generate the Cookbook

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

* Run the makebook.sh script to generate the PDF. 
* The md2pdf tool is still python2

