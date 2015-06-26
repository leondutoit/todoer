
# trying to avoid files

ack -l TODO |
    xargs grep -n TODO |
    cut -d : -f 1,2 |
    sed "s/\(.*\):\(.*\)/\1,\2/g" |
    tr , '\n' |
    while read line1; read line2; do git blame --date iso $line1 -L $line2,$line2; done |
    sed 's/\(^.*\)\((.*....-..-..\.*)\)\(.*$\)/\2/g' |
    sed 's/.*\(....-..-..\).*/\1/g' |
    grep -v '^.*[a-zA-Z].*'
