# Base image
FROM golang:1.8-alpine

MAINTAINER Warnar Boekkooi <wbo@hellofresh.com>

# Install dependencies
RUN apk add --upgrade --no-cache jq curl git subversion openssh openssl mercurial bash \
    && curl https://glide.sh/get | sh

# Install git lfs
ADD scripts/install_git_lfs.sh install_git_lfs.sh
RUN ./install_git_lfs.sh

# According to https://github.com/concourse/buildroot-images/blob/master/git/Dockerfile
# can't `git pull` unless we set these
RUN git config --global user.email "git@localhost" && \
    git config --global user.name "git"

# Add assets
ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*

# Command SH
CMD ["/bin/sh"]
