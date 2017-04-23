FROM centos:6.8

ADD ./conf/nginx.repo /etc/yum.repos.d/

# install apps
RUN yum clean metadata && yum clean all && yum update -y \
  && yum localinstall -y http://rpms.famillecollet.com/enterprise/remi-release-6.rpm \
  && yum install -y supervisor \
  && yum install -y nginx-1.10.1 \
  && yum install --enablerepo=remi-php70 -y \
      php \
      php-fpm \
      php-cli \
      php-mcrypt \
      php-common \
      php-devel \
      php-mbstring \
      php-mysqlnd \
      php-opcache \
      php-pdo \
      php-pear \
      php-pecl-apcu \
      php-pecl-zip \
      php-process \
      php-xml \
      php-intl \
      php-soap \
      php-pecl-memcache \
      php-pecl-memcached \
      php-couchbase \
  && yum clean all

# setting mysql client
RUN yum localinstall -y http://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm \
  && yum install -y mysql-community-client \
  && yum clean all

# setting php-fpm
RUN sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Asia\/Tokyo/g' /etc/php.ini \
    && sed -i "s/expose_php=.*/expose_php=Off/" /etc/php.ini \
    && sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php-fpm.conf \
    && echo "error_log /var/log/php-fpm/php-fpm.log" /etc/php-fpm.conf \
    && sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php-fpm.d/www.conf \
    && sed -i -e "s/user\s*=.*/user = nginx/g" /etc/php-fpm.d/www.conf \
    && sed -i -e "s/group\s*=.*/group = nginx/g" /etc/php-fpm.d/www.conf \
    && echo "php_admin_value[display_errors] = 'stderr'" >> /etc/php-fpm.d/www.conf \
    && echo "listen = /var/run/php-fpm/php-fpm.sock" >> /etc/php-fpm.d/www.conf \
    && echo "listen.owner = nginx" >> /etc/php-fpm.d/www.conf \
    && echo "listen.group = nginx" >> /etc/php-fpm.d/www.conf \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 20M/" /etc/php.ini \
    && sed -i "s/post_max_size = 2M/post_max_size = 20M/" /etc/php.ini
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php-fpm.conf

# git
RUN yum install -y git

# setting nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/server.conf /etc/nginx/conf.d/server.conf
RUN echo '<?php phpinfo();' >> /var/www/html/index.php
RUN usermod -u 1000 nginx

# setting supervisord
# ADD ./conf/supervisord.conf /etc/supervisord.conf


# composer
WORKDIR /tmp

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer self-update

# npm
RUN yum -y install epel-release
RUN yum -y install nodejs npm
RUN npm update -g npm
RUN npm cache clean
RUN npm i -g n
RUN npm i -g gulp-cli
RUN npm i -g grunt-cli
RUN npm i -g browserify
RUN npm i -g uglify-js
RUN npm i -g webpack

# start php & nginx
# CMD /usr/bin/supervisord -c /etc/supervisord.conf

ADD ./conf/start.sh /tmp/start.sh
CMD /bin/sh /tmp/start.sh

EXPOSE 80 443
