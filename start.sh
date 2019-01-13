#!/bin/bash
docker run --rm -it -v /:/host -p 127.0.0.1:60022:22 -a stdin -a stdout vim
