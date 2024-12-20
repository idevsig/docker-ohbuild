FROM ubuntu:24.04
LABEL maintainer="Jetsung Chan<jetsungchan@gmail.com>"

WORKDIR /openharmony

# https://github.com/GerritCodeReview/git-repo/raw/refs/heads/main/repo 
# RUN curl -fsSL -o /usr/local/bin/repo https://mirrors.tuna.tsinghua.edu.cn/git/git-repo 
ADD https://mirrors.tuna.tsinghua.edu.cn/git/git-repo /usr/local/bin/repo
RUN chmod +x /usr/local/bin/repo

RUN sed -i "s@http://.*archive.ubuntu.com@http://mirrors.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources
RUN sed -i "s@http://.*security.ubuntu.com@http://mirrors.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources

RUN apt update 
RUN apt install -y \
    binutils git git-lfs gnupg flex \
    bison gperf build-essential zip wget curl zlib1g-dev gcc-multilib g++-multilib \
    libc6-dev-i386 lib32ncurses-dev x11proto-core-dev libx11-dev lib32z1-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip m4 bc gnutls-bin \
    python3 python-is-python3 python3-pip python3-venv \
    ruby device-tree-compiler lib32stdc++6 lib32z1 libncurses-dev \
    scons genext2fs abootimg

RUN apt install -y default-jdk gcc-arm-linux-gnueabi gcc-arm-none-eabi liblz4-tool libssl-dev mtd-utils mtools openssl u-boot-tools libtinfo6

RUN git config --global user.name "openharmony"
RUN git config --global user.email "build@openharmony.cn"
RUN git config --global credential.helper store

RUN python -m venv ~/myenv
RUN echo '. ~/myenv/bin/activate' >> ~/.bashrc
RUN echo 'export REPO_URL="https://mirrors.tuna.tsinghua.edu.cn/git/git-repo"' >> ~/.bashrc

RUN . ~/myenv/bin/activate && pip3 install -i https://repo.huaweicloud.com/repository/pypi/simple requests

CMD [ "repo" ]