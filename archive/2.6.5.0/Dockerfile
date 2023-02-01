FROM ubuntu:18.04 AS build-env

#http://nginx.org/en/download.html
ENV NGINX_VERSION 1.16.1
#https://www.php.net/
ENV PHP_VERSION 7.4.20

#if not set WORKDIR, each RUN & CMD & ADD & COPY ... need to run `cd /usr/local/src`
WORKDIR /usr/local/src

RUN apt-get -y update
RUN apt-get install -y wget
# 16.04 libreadline6-dev
# 18.04 libreadline-dev  add: libzip-dev
RUN apt-get install -y build-essential autoconf make automake bison re2c libxml2-dev libssl-dev libfreetype6-dev libcurl4-gnutls-dev libjpeg-dev libpng-dev libreadline-dev  pkg-config libzip-dev
# for PHP 7.4
RUN apt-get install -y libsqlite3-dev libonig-dev

#Add user  && download php and nginx source code
#    groupadd -r www && \
#    useradd -M -s /sbin/nologin -r -g www www && /sbin/usermod -u 1000 www && \
# -M, --no-create-home
# -m, --create-home   Create the user's home directory if it does not exist.
# composer install需要
#   Cannot create cache directory /home/www/.composer/cache/repo/https---packagist.org/, or directory is not writable. Proceeding without cache
#   Cannot create cache directory /home/www/.composer/cache/files/, or directory is not writable. Proceeding without cache
# for php pecl install *** autoconf
RUN useradd -m -s /sbin/nologin www
RUN wget -c -O nginx.tar.gz http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
RUN tar -zxf nginx.tar.gz && rm -f nginx.tar.gz && \
     cd nginx-${NGINX_VERSION} && \
    ./configure --prefix=/usr/local/nginx \
    --user=www --group=www \
    --pid-path=/var/run/nginx.pid \
    --with-pcre \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --with-http_v2_module \
    --with-http_ssl_module \
    --with-http_gzip_static_module \
    --with-http_stub_status_module && \
    make -j4 > /dev/null && make install
#    --error-log-path=/var/log/nginx/error.log \
#    --http-log-path=/var/log/nginx/access.log \
#    --conf-path=/usr/local/nginx/nginx.conf \

RUN wget -c -O php.tar.gz http://php.net/distributions/php-${PHP_VERSION}.tar.gz
RUN tar zxf php.tar.gz && rm -f php.tar.gz && \
     cd php-${PHP_VERSION} && \
    ./configure --prefix=/usr/local/php \
    --with-config-file-path=/usr/local/php/etc \
    --with-config-file-scan-dir=/usr/local/php/etc/php.d \
    --with-fpm-user=www \
    --with-fpm-group=www \
    --with-mysqli \
    --with-pdo-mysql \
    --with-openssl \
    --enable-gd \
    --with-iconv \
    --with-zlib \
    --with-gettext \
    --with-curl \
    --with-jpeg \
    --with-freetype \
    --enable-fpm \
    --enable-xml \
    --enable-inline-optimization \
    --enable-mbregex \
    --enable-mbstring \
    --enable-mysqlnd \
    --enable-sockets \
    --with-zip \
    --enable-soap \
    --enable-bcmath \
    --enable-exif \
    --enable-pcntl \
    --disable-cgi \
    --disable-phpdbg \
    --with-pear \
    && \
    make -j4 > /dev/null && make install;
#    --with-xmlrpc \  This extension is EXPERIMENTAL.
#    --with-mhash \
#    --disable-ctype \
#    --enable-shmop \
#    --enable-sysvsem \
#    --enable-ftp \
# 从PHP7.4 开始需要手动 --with-pear, 之前是--without-pear
# PEAR is disabled by default on PHP 7.4. As "PECL is a repository of PHP extensions that are made available to you via the PEAR packaging system", it also removes the PECL too.

RUN cp ./php-${PHP_VERSION}/php.ini-production /usr/local/php/etc/php.ini && \
    mv /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \
    mv /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf  && \
    strip /usr/local/php/bin/php && \
    strip /usr/local/php/sbin/php-fpm && \
    strip /usr/local/nginx/sbin/nginx && \
    strip /usr/local/php/lib/php/extensions/no-debug-non-zts-20190902/opcache.a && \
    strip /usr/local/php/lib/php/extensions/no-debug-non-zts-20190902/opcache.so

RUN sed -i 's/^;date\.timezone[ ]*=[ ]*/date\.timezone = Asia\/Shanghai/' /usr/local/php/etc/php.ini  && \
    sed -i 's/^session\.use_strict_mode = 0/session\.use_strict_mode = 1/' /usr/local/php/etc/php.ini  && \
    sed -i 's/^session\.cookie_httponly =$/session\.cookie_httponly = 1/' /usr/local/php/etc/php.ini && \
    sed -i 's/^memory_limit = 128M/memory_limit = 128M/' /usr/local/php/etc/php.ini && \
    sed -i 's/^expose_php = On/expose_php = Off/' /usr/local/php/etc/php.ini && \
    sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 100M/' /usr/local/php/etc/php.ini && \
    sed -i 's/^max_execution_time = 30/max_execution_time = 60/' /usr/local/php/etc/php.ini && \
    sed -i 's/^;request_terminate_timeout = 0/request_terminate_timeout = 120/' /usr/local/php/etc/php-fpm.d/www.conf && \
    sed -i 's/^listen = 127\.0\.0\.1:9000/listen = \/var\/run\/php-fpm\.sock/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^;listen.owner = www/listen.owner = www/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^;listen.group = www/listen.group = www/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^;listen.mode = 0660/listen.mode = 0660/' /usr/local/php/etc/php-fpm.d/www.conf
#    sed -i 's/^;cgi\.fix_pathinfo[ ]*=[ ]*1/cgi\.fix_pathinfo=0/' /usr/local/php/etc/php.ini
#    sed -i 's/^;security\.limit_extensions .../default setting is safe/' /usr/local/php/etc/php-fpm.d/www.conf  && \

# phpize need `/usr/local/php/include`
RUN rm -rf /usr/local/php/include



FROM ubuntu:18.04
COPY --from=build-env /usr/local/nginx /usr/local/nginx
COPY --from=build-env /usr/local/php /usr/local/php

COPY --from=build-env   \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/libcom_err.so.2 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libcrypt.so.1 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/libkeyutils.so.1 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libresolv.so.2 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    \
    /lib/x86_64-linux-gnu/

COPY --from=build-env   \
    /usr/lib/x86_64-linux-gnu/libhx509.so.5  \
    /usr/lib/x86_64-linux-gnu/libsqlite3.so.0  \
    /usr/lib/x86_64-linux-gnu/libjpeg.so.8   \
    /usr/lib/x86_64-linux-gnu/libpng16.so.16   \
    /usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.4   \
    /usr/lib/x86_64-linux-gnu/libssl.so.1.1   \
    /usr/lib/x86_64-linux-gnu/libasn1.so.8   \
    /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1   \
    /usr/lib/x86_64-linux-gnu/libgnutls.so.30   \
    /usr/lib/x86_64-linux-gnu/libhcrypto.so.4   \
    /usr/lib/x86_64-linux-gnu/libheimbase.so.1   \
    /usr/lib/x86_64-linux-gnu/libhogweed.so.4   \
    /usr/lib/x86_64-linux-gnu/libidn2.so.0   \
    /usr/lib/x86_64-linux-gnu/libk5crypto.so.3   \
    /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2   \
    /usr/lib/x86_64-linux-gnu/libnettle.so.6   \
    /usr/lib/x86_64-linux-gnu/libroken.so.18   \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6   \
    /usr/lib/x86_64-linux-gnu/libwind.so.0   \
    /usr/lib/x86_64-linux-gnu/libxml2.so.2   \
    /usr/lib/x86_64-linux-gnu/libfreetype.so.6  \
    /usr/lib/x86_64-linux-gnu/libicuuc.so.60  \
    /usr/lib/x86_64-linux-gnu/libnghttp2.so.14  \
    /usr/lib/x86_64-linux-gnu/librtmp.so.1   \
    /usr/lib/x86_64-linux-gnu/libpsl.so.5   \
    /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2   \
    /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2   \
    /usr/lib/x86_64-linux-gnu/libicudata.so.60   \
    /usr/lib/x86_64-linux-gnu/libunistring.so.2   \
    /usr/lib/x86_64-linux-gnu/libgmp.so.10   \
    /usr/lib/x86_64-linux-gnu/libp11-kit.so.0   \
    /usr/lib/x86_64-linux-gnu/libtasn1.so.6   \
    /usr/lib/x86_64-linux-gnu/libkrb5.so.26   \
    /usr/lib/x86_64-linux-gnu/libkrb5support.so.0   \
    /usr/lib/x86_64-linux-gnu/libkrb5.so.3   \
    /usr/lib/x86_64-linux-gnu/libsasl2.so.2   \
    /usr/lib/x86_64-linux-gnu/libgssapi.so.3   \
    /usr/lib/x86_64-linux-gnu/libffi.so.6   \
    /usr/lib/x86_64-linux-gnu/libheimntlm.so.0   \
    /usr/lib/x86_64-linux-gnu/libonig.so.4 \
    /usr/lib/x86_64-linux-gnu/libzip.so.4 \
    \
    /usr/lib/x86_64-linux-gnu/
# 18.04 add:
# COPY --from=build-env  /usr/lib/x86_64-linux-gnu/libzip.so.4    /usr/lib/x86_64-linux-gnu/

#overwrite nginx.conf
ADD conf/nginx.conf /usr/local/nginx/conf/nginx.conf
ADD conf/default_server.conf /etc/nginx/conf.d/default_server.conf
ADD start.sh /start.sh

# /var/lib/apt/lists is huge
RUN useradd -m -s /sbin/nologin www && \
    mkdir /var/log/nginx && \
    mkdir -p /etc/nginx/conf.d && \
    mkdir -p /app/web && chown -R www:www /app && \
    ln  -s  /usr/local/php/bin/php    /usr/local/bin/php && \
    ln  -s  /usr/local/php/bin/phpize    /usr/local/bin/phpize && \
    ln  -s  /usr/local/php/bin/pecl    /usr/local/bin/pecl && \
    ln  -s  /usr/local/php/bin/php-config    /usr/local/bin/php-config && \
    ln  -s  /usr/local/nginx/sbin/nginx    /usr/local/sbin/nginx && \
    chmod 755 /start.sh && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime && \
    apt-get update && apt-get install -y tzdata ca-certificates && apt-get clean && rm -rf /var/lib/apt/lists/*
# 先建软链，再安装tzdata 就不需要dpkg-reconfigure -f noninteractive tzdata； 或者参考：https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image

COPY ./html /app/web
COPY ./mv /
COPY conf/php.ini /usr/local/php/etc

RUN chown -R www:www /app/web \
&& chmod 755 /app/web

WORKDIR /app/web

VOLUME ["/app/web/i"]
VOLUME ["/app/web/config"]

#Set port
EXPOSE 80 

#Start it
ENTRYPOINT ["/start.sh"]



## docker buildx build -t ddsderek/ddsderek:latest --platform=linux/amd64 G:\桌面\Docker镜像制作\Easyimage\2.6.5 --push
## docker buildx build -t ddsderek/ddsderek:2.6.5 --platform=linux/amd64 G:\桌面\Docker镜像制作\Easyimage\2.6.5 --push