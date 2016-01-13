FROM ubuntu:14.04

###########
# system
###########

RUN adduser --disabled-password --gecos "" ubuntu
RUN gpasswd -a ubuntu sudo && \
    gpasswd -a ubuntu adm

WORKDIR /tmp/work

# basic packages
RUN apt-get update -y
RUN apt-get install -y \
        git vim emacs \
        curl wget jq \
        tree tmux zsh \
        build-essential

# peco
RUN wget https://github.com/peco/peco/releases/download/v0.3.5/peco_linux_amd64.tar.gz &&\
    tar zxvf peco_linux_amd64.tar.gz &&\
    sudo mv peco_linux_amd64/peco /usr/local/bin \

###########
# user
###########

USER ubuntu

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# python
RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv && \
    cd /home/ore/.pyenv/plugins && \
    git clone git://github.com/yyuu/pyenv-virtualenv.git && \
    pyenv install 2.7.9

# ruby

