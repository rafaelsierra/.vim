FROM debian:9

RUN sh -c "\
  apt-get update && \
  apt-get install -y python3 python3-pip ack git golang rustc cargo bash sudo openssh-server vim-gtk &&\
  pip3 install jedi flake8 \
"
ARG USER
ARG UID
ENV USER ${USER}
ENV HOME=/home/${USER}
ENV UID=${UID}

RUN adduser --disabled-password --home $HOME --uid $UID --shell /bin/bash $USER
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
