#!/usr/bin/env bash


if [ ! -f "/app/web/config/config.php" ]; then
 echo "配置文件不存在，正在创建" && \
 mv /config/api_key.php /app/web/config
 mv /config/config.guest.php /app/web/config
 mv /config/config.manager.php /app/web/config
 mv /config/config.php /app/web/config
 mv /i/.htaccess /app/web/i
 mv /i/index.html /app/web/i
 chown -R www:www /app/web
 chmod 755 /app/web
else
 echo "配置文件存在" && 
 rm -rf /config/
 rm -rf /i/
 chown -R www:www /app/web
 chmod 755 /app/web
fi

/usr/local/php/sbin/php-fpm
#/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
/usr/local/nginx/sbin/nginx

#tail -f /start.sh
#tail -f /usr/local/php/var/log/php-fpm.log
tail -f /var/log/nginx/error.log;
