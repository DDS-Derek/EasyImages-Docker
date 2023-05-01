FROM debian:bullseye-slim

ENV S6_SERVICES_GRACETIME=30000 \
    S6_KILL_GRACETIME=60000 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_SYNC_DISKS=1 \
    HOME="/root" \
    TERM="xterm" \
    PATH=${PATH}:/command \
    DEBUG=false \
    TZ="Asia/Shanghai" \
    PUID=0 \
    PGID=0

COPY --from=shinsenter/s6-overlay / /
RUN set -ex && \
    export DEBIAN_FRONTEND=noninteractive && \
    ln -sf /command/with-contenv /usr/bin/with-contenv && \
    apt-get update -y && \
    apt-get install -y \
        bash \
        curl \
        busybox \
        xz-utils \
        procps && \
    apt-get install -y \
        nginx \
        php7.4 \
        php7.4-common \
        php7.4-curl \
        php7.4-fpm \
        php7.4-json \
        php7.4-xml \
        php7.4-zip \
        php7.4-gd \
        php7.4-mbstring \
        php7.4-bcmath && \
    rm -rf \
        /etc/nginx/sites-enabled/default \
        /etc/nginx/sites-available/default \
        /etc/php/7.4/fpm/pool.d/www.conf && \
    # Set size
    echo "max_execution_time = 6000" > /etc/php/7.4/mods-available/web_size.ini && \
    echo "max_input_time = 6000" >> /etc/php/7.4/mods-available/web_size.ini && \
    echo "memory_limit = 512m" >> /etc/php/7.4/mods-available/web_size.ini && \
    echo "file_uploads = on" >> /etc/php/7.4/mods-available/web_size.ini && \
    echo "upload_tmp_dir = /tmp" >> /etc/php/7.4/mods-available/web_size.ini && \
    echo "upload_max_filesize = 512m" >> /etc/php/7.4/mods-available/web_size.ini && \
    echo "post_max_size = 512m" >> /etc/php/7.4/mods-available/web_size.ini && \
    ln -sf /etc/php/7.4/mods-available/web_size.ini /etc/php/7.4/cli/conf.d/10-web_size.ini && \
    ln -sf /etc/php/7.4/mods-available/web_size.ini /etc/php/7.4/fpm/conf.d/10-web_size.ini && \
    # Set opcache
    sed -i "s#;opcache.enable=1#opcache.enable=1#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    sed -i "s#;opcache.enable_cli=1#opcache.enable_cli=1#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    sed -i "s#;opcache.memory_consumption=128#opcache.memory_consumption=128#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    sed -i "s#;opcache.interned_strings_buffer=8#opcache.interned_strings_buffer=8#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    sed -i "s#;opcache.max_accelerated_files=10000#opcache.max_accelerated_files=4000#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    sed -i "s#;opcache.revalidate_freq=2#opcache.revalidate_freq=60#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    sed -i "s#;opcache.validate_timestamps=1#opcache.validate_timestamps=0#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    sed -i "s#;opcache.lockfile_path=/tmp#opcache.lockfile_path=/tmp#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    # Set php pid
    mkdir /run/php && \
    # Set user
    usermod www-data --home /app/web && \
    # Set logs
    sed -i "s#;error_log = php_errors.log#error_log = /logs/php_errors.log#g" /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini && \
    mkdir /logs && \
    touch /logs/nginx_access.log && \
    touch /logs/nginx_error.log && \
    touch /logs/php7.4-fpm.log && \
    touch /logs/php_errors.log && \
    # Clear
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf \
	    /tmp/* \
	    /var/lib/apt/lists/* \
	    /var/tmp/*

ARG EASYIMAGES_VERSION

RUN mkdir -p /app && \
    curl -L https://github.com/icret/EasyImages2.0/archive/refs/tags/${EASYIMAGES_VERSION}.zip | busybox unzip -qd /app - && \
    mv /app/EasyImages2.0-${EASYIMAGES_VERSION} /app/web && \
    curl -L https://github.com/lionsoul2014/ip2region/raw/master/data/ip2region.xdb -o /app/web/app/ip2region/ip2region.xdb && \
    cp -r /app/web/config / && \
    cp -r /app/web/i /

COPY --chmod=755 ./rootfs /

ENTRYPOINT [ "/init" ]

EXPOSE 80