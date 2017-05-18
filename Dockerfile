FROM ubuntu:16.04

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install \
# development tools
g++ gcc make \
# editor and utilities
vim emacs less wget man-db \
# python 2.7
python python-virtualenv \
# python 3.5
python3 python3-venv \
# php
php php-cli \
# version control
git

# install nodejs from source code
RUN mkdir -p /usr/local/src && cd /usr/local/src && wget https://nodejs.org/dist/v7.9.0/node-v7.9.0.tar.gz && tar zxvf node-v7.9.0.tar.gz

RUN cd /usr/local/src/node-v7.9.0 && ./configure --prefix=/usr/local/node7.9.0 && make && make install

ENV PATH /usr/local/node7.9.0/global/bin:/usr/local/node7.9.0/bin:$PATH

RUN npm config set prefix /usr/local/node7.9.0/global && npm install -g npm@latest

# Mongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list

RUN apt-get -y update && apt-get install -y mongodb-org

# React
RUN npm install -g create-react-app

# python2.7 virtual environment
RUN cd /usr/local && virtualenv --always-copy python27venv && /usr/local/python27venv/bin/python -mpip install -U pip

COPY ./requirements.txt /usr/local/python27venv

RUN /usr/local/python27venv/bin/python -m pip install -r /usr/local/python27venv/requirements.txt

# python3.5 virtual environment
RUN cd /usr/local && python3 -mvenv --copies python35venv && /usr/local/python35venv/bin/python -mpip install -U pip

COPY ./requirements.txt /usr/local/python35venv

RUN /usr/local/python35venv/bin/python -m pip install -r /usr/local/python35venv/requirements.txt
