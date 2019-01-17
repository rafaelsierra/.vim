#!/bin/bash
FILENAME=""
DIRNAME=""
if [ -s "$1" ]; then
    FILENAME=/host/$(python -c "import os;print os.path.realpath('$1')")
    DIRNAME=$(dirname $FILENAME)
    FILENAME=$(basename $FILENAME)
else
    DIRNAME=/host$(pwd)
fi
ssh -X -Y -t -i ~/.ssh/id_rsa-vim -p 60022 $USER@localhost "cd $DIRNAME && gvim $FILENAME"

