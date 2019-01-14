FROM alpine

RUN sh -c "\
  apk update && \
  apk add vim python3 ack git go rust cargo bash sudo openssh-server shadow &&\
  pip3 install jedi flake8 \
"
ARG USER
ARG UID
ENV USER ${USER}
ENV HOME=/home/${USER}
ENV UID=${UID}

RUN adduser -D -h $HOME -u $UID -s /bin/bash $USER
RUN usermod -p '*' $USER

WORKDIR $HOME

RUN printf "%s ALL=(ALL) NOPASSWD: ALL\n" $USER > /etc/sudoers.d/$USER

COPY . .vim/
COPY .vimrc .
COPY sshd_config /etc/ssh/
COPY entrypoint.sh /entrypoint.sh

RUN chown -R $USER .vimrc .vim

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
