FROM ubuntu:16.04

RUN apt-get -y update && apt-get -y upgrade && \
# development tools
apt-get -y install g++ gcc make \
# wget
wget \
# python 2.7
python \
# php
php php-cli

# install nodejs from source code
RUN mkdir -p /usr/local/src && cd /usr/local/src && wget https://nodejs.org/dist/v7.9.0/node-v7.9.0.tar.gz && tar zxvf node-v7.9.0.tar.gz

RUN cd /usr/local/src/node-v7.9.0 && ./configure --prefix=/usr/local/node7.9.0 && make && make install

ENV PATH /usr/local/node7.9.0/global/bin:/usr/local/node7.9.0/bin:$PATH

RUN npm config set prefix /usr/local/node7.9.0/global && npm install -g npm@latest

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list

RUN apt-get -y update && apt-get install -y mongodb-org

# RUN echo "export PATH=/usr/local/node7.9.0/bin:$PATH" >> ~/.bashrc

