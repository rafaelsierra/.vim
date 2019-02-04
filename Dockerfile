FROM debian:9

#
# Package requirements
#
RUN sh -c "\
  apt-get update && \
  apt-get install -y python3 python3-pip ack git golang curl bash sudo \
  exuberant-ctags xfonts-utils fontconfig vim && \
  pip3 install jedi flake8 \
"
ENV LC_ALL=C.UTF-8

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
RUN adduser --gecos ",,," --disabled-password --home $HOME --uid $UID --shell /bin/bash $USER
RUN usermod -p '*' $USER
RUN printf "%s ALL=(ALL) NOPASSWD: ALL\n" $USER > /etc/sudoers.d/$USER

USER $USER
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

#
# Install SpaceVim
#
RUN mkdir -p $HOME/.vim/files/info
RUN curl -sLf https://spacevim.org/install.sh | bash

WORKDIR $HOME
