FROM alpine

RUN sh -c "\
  apk update && \
  apk add vim python3 ack git go rust cargo bash sudo &&\ 
  pip3 install jedi \
"

ENV USER rafael
ENV HOME /home/rafael
ENV UID 1000
ENV TERM xterm-256color

RUN adduser -D -h $HOME -u $UID -s /bin/bash $USER
ENV PS1 '$USER@docker-vim \w$ '
WORKDIR $HOME

RUN printf "%s ALL=(ALL) NOPASSWD: ALL\n" $USER > /etc/sudoers.d/$USER
USER $USER

COPY . .vim/
COPY .vimrc .

CMD vim
