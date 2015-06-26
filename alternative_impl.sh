#!/bin/bash

prep_output() {
    xargs grep -n TODO |
    cut -d : -f 1,2 |
    sed "s/\(.*\):\(.*\)/\1,\2/g" |
    tr , '\n'
}

blame() {
    while read line1; read line2; do
        git blame --date iso $line1 -L $line2,$line2;
    done
}

get_dates() {
    sed 's/\(^.*\)\((.*....-..-..\.*)\)\(.*$\)/\2/g' |
    sed 's/.*\(....-..-..\).*/\1/g' |
    grep -v '^.*[a-zA-Z].*'
}

to_days() {
    while read date1; do
        currdate=$(date '+%s');
        d=$(date -jf "%Y-%m-%d" ${date1} '+%s');
        ddiff=`expr $currdate - $d`;
        days=`expr $ddiff / 86400`;
        echo $days;
    done
}

to_approx_years() {
    while read day1; do
        appr_yrs=$(echo "scale = 1; x = $day1 / 365; if (x < 1) print 0; x" | bc);
        echo $appr_yrs;
    done;
}

hist() {
    sort |
    uniq -c |
    sort -rn |
    awk '!max{max=$1+"";}{r="";i=s=60*$1/max;while(i-->0){r=r"#";}printf "%15s yrs %5d %s %s",$2,$1,r,"\n";}'
}

report() {
    ack -l TODO |
    prep_output |
    blame |
    get_dates |
    to_days |
    to_approx_years |
    hist
}

trap "echo Nothing to report then..." SIGINT SIGTERM
cd $1
report
