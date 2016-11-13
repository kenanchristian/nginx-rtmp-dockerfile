FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive
ENV PATH $PATH:/usr/local/nginx/sbin

EXPOSE 1935
EXPOSE 80

# install vim
RUN apt-get update && apt-get upgrade -y && apt-get clean
RUN apt-get install -y vim

# install cURL
RUN apt-get install -y curl

# install git
RUN apt-get install -y git

# install NPM and NODE
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
RUN apt-get install -y nodejs

# fucking debian installs `node` as `nodejs`
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10



# create directories
RUN mkdir /src && mkdir /config && mkdir /logs && mkdir /data && mkdir /static

RUN apt-get install -y build-essential wget

# ffmpeg
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:mc3man/trusty-media
RUN apt-get update
RUN apt-get install -y ffmpeg

# nginx dependencies
RUN apt-get install -y libpcre3-dev zlib1g-dev libssl-dev
RUN apt-get install -y wget

# get nginx source
RUN cd /src && wget http://nginx.org/download/nginx-1.6.2.tar.gz && tar zxf nginx-1.6.2.tar.gz && rm nginx-1.6.2.tar.gz

# get nginx-rtmp module
RUN cd /src && wget https://github.com/arut/nginx-rtmp-module/archive/v1.1.6.tar.gz && tar zxf v1.1.6.tar.gz && rm v1.1.6.tar.gz

# compile nginx
RUN cd /src/nginx-1.6.2 && ./configure --add-module=/src/nginx-rtmp-module-1.1.6 --conf-path=/config/nginx.conf --error-log-path=/logs/error.log --http-log-path=/logs/access.log
RUN cd /src/nginx-1.6.2 && make && make install

# install hls-live-thumbnail
RUN sudo npm install -g hls-live-thumbnails

ADD nginx.conf /config/nginx.conf
ADD static /static

CMD "nginx"

