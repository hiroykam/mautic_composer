FROM centos:6.8

RUN yum -y install epel-release
RUN yum -y install nodejs npm
RUN npm update -g npm
RUN npm cache clean
RUN npm i -g n
RUN npm i -g gulp-cli

RUN mkdir -p /data/www
VOLUME ["/data"]
WORKDIR /data/www

ENTRYPOINT ["npm"]
CMD ["-h"]
