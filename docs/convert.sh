for i in `ls -R *.rst`; do
    readarray -d . -t strarr <<<  ${i}
    echo "the name is ${strarr[-2]}"
    pandoc --from=rst --to=markdown --output=${strarr[-2]}.md ${i}
    rm ${i}
done

for i in `ls -R */*.rst`; do
    readarray -d . -t strarr <<<  ${i}
    echo "the name is ${strarr[-2]}"
    pandoc --from=rst --to=markdown --output=${strarr[-2]}.md ${i}
    rm ${i}
done

for i in `ls -R */*/*.rst`; do
    readarray -d . -t strarr <<<  ${i}
    echo "the name is ${strarr[-2]}"
    pandoc --from=rst --to=markdown --output=${strarr[-2]}.md ${i}
    rm ${i}
done
