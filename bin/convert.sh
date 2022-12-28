#!/bin/bash 

# devsecfranklin@duck.com

for i in `ls -R *.md`; do
    readarray -d . -t strarr <<<  ${i}
    echo "the name is ${strarr[-2]}"
    pandoc --from=markdown --to=rst --output=${strarr[-2]}.rst ${i}
    rm ${i}
done

for i in `ls -R */*.md`; do
    readarray -d . -t strarr <<<  ${i}
    echo "the name is ${strarr[-2]}"
    pandoc --from=markdown --to=rst --output=${strarr[-2]}.rst ${i}
    rm ${i}
done

for i in `ls -R */*/*.md`; do
    readarray -d . -t strarr <<<  ${i}
    echo "the name is ${strarr[-2]}"
    pandoc --from=markdown --to=rst --output=${strarr[-2]}.rst ${i}
    rm ${i}
done
