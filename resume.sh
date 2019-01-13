#!/bin/bash
docker run --rm -it --entrypoint /usr/sbin/sshd -v /:/host -p 127.0.0.1:60022:22 vim:snapshot -D
