FROM ubuntu:14.04

###########
# system
###########

RUN adduser --disabled-password --gecos "" ubuntu
RUN gpasswd -a ubuntu sudo && \
    gpasswd -a ubuntu adm
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/ubuntu

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
    sudo mv peco_linux_amd64/peco /usr/local/bin


###########
# user
###########

USER ubuntu
WORKDIR /tmp/work_ubuntu
ENV HOME /home/ubuntu

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" ; exit 0

# python
ADD pyenv_rc pyenv_rc
RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv && \
    cd /home/ubuntu/.pyenv/plugins && \
    git clone git://github.com/yyuu/pyenv-virtualenv.git
RUN cat pyenv_rc >> $HOME/.zshrc && echo $HOME/.zshrc

RUN sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev
RUN /home/ubuntu/.pyenv/bin/pyenv install 2.7.9
RUN /home/ubuntu/.pyenv/bin/pyenv install 3.5.1

# ruby

WORKDIR /home/ubuntu
CMD /bin/zsh