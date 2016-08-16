#!/bin/sh
# @Author: dabeen
# @Date:   2016-08-09 18:06:53
# @Last Modified by:   dabeen
# @Last Modified time: 2016-08-16 16:06:31

#currentPath=`pwd`

resolvePath='.'
if [ $# -gt 0 ]; then
    resolvePath=$1
fi

total=0
function handlePath () {
    # echo 'enter '`pwd`'\'$1
    cd $1
    list=`ls -A`
    for file in `ls -A`; do
        if [ $file = '.DS_Store' ]; then
            size=`du -s .DS_Store | cut -f1 `
            total=$[total+size]
            echo 'del '`pwd`'/.DS_Store'
            rm -rf .DS_Store
        elif [ -d $file ]; then
            handlePath $file;
        fi
    done
    # echo 'out '`pwd`
    cd ..
}

handlePath $resolvePath

echo '清理出空间：'$total
