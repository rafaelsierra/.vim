FROM debian:9

#
# Package requirements
#
RUN sh -c "\
  apt-get update && \
  apt-get install -y python3 python3-pip ack git golang curl bash sudo openssh-server vim-gtk exuberant-ctags &&\
  pip3 install jedi flake8 \
"

#
# Build and env setup
#
ARG USER
ARG UID
ENV USER ${USER}
ENV HOME=/home/${USER}
ENV UID=${UID}
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.cargo/bin
#
# User setup
#
RUN adduser --disabled-password --home $HOME --uid $UID --shell /bin/bash $USER
RUN usermod -p '*' $USER
RUN printf "%s ALL=(ALL) NOPASSWD: ALL\n" $USER > /etc/sudoers.d/$USER

USER $USER
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

WORKDIR $HOME

COPY . .vim/
COPY .vimrc .
COPY sshd_config /etc/ssh/
COPY entrypoint.sh /entrypoint.sh

USER root
RUN chown -R $USER $HOME/.vim

RUN ln -s $HOME/.cargo/bin/rustfmt /usr/bin/
EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
