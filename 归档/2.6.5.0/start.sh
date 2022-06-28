#!/usr/bin/env bash

######################################################## 创建配置文件 #############################################################
if [ ! -f "/app/web/config/config.php" ]; then
 echo -e "\033[36m config.php文件不存在,正在创建... \033[0m"
 mv /config/config.php /app/web/config
 echo "config.php文件创建成功"
else
 echo "config.php文件存在"
 chown -R www:www /app/web
 chmod 755 /app/web
 rm -rf /config/config.php
fi

if [ ! -f "/app/web/config/api_key.php" ]; then
 echo -e "\033[36m api_key.php文件不存在,正在创建... \033[0m"
 mv /config/api_key.php /app/web/config
 echo "api_key.php文件创建成功"
else
 echo "api_key.php文件存在"
 chown -R www:www /app/web
 chmod 755 /app/web
 rm -rf /config/api_key.php
fi

if [ ! -f "/app/web/config/config.guest.php" ]; then
 echo -e "\033[36m config.guest.php文件不存在,正在创建... \033[0m"
 mv /config/config.guest.php /app/web/config
 echo "config.guest.php文件创建成功"
else
 echo "config.guest.php文件存在"
 chown -R www:www /app/web
 chmod 755 /app/web
 rm -rf /config/config.guest.php
fi

if [ ! -f "/app/web/config/config.manager.php" ]; then
 echo -e "\033[36m config.manager.php文件不存在,正在创建... \033[0m"
 mv /config/config.manager.php /app/web/config
 echo "config.manager.php文件创建成功"
else
 echo "config.manager.php文件存在"
 chown -R www:www /app/web
 chmod 755 /app/web
 rm -rf /config/config.manager.php
fi

if [ ! -f "/app/web/i/.htaccess" ]; then
 echo -e "\033[36m .htaccess文件不存在,正在创建... \033[0m"
 mv /i/.htaccess /app/web/i
 echo ".htaccess文件创建成功"
else
 echo ".htaccess文件存在"
 chown -R www:www /app/web
 chmod 755 /app/web
 rm -rf /i/.htaccess
fi

if [ ! -f "/app/web/i/index.html" ]; then
 echo -e "\033[36m index.html文件不存在,正在创建... \033[0m"
 mv /i/index.html /app/web/i
 echo "index.html文件创建成功"
else
 echo "index.html文件存在"
 chown -R www:www /app/web
 chmod 755 /app/web
 rm -rf /i/index.html
fi


######################################################## 启动nginx,php #############################################################
/usr/local/php/sbin/php-fpm
#/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
/usr/local/nginx/sbin/nginx

#tail -f /start.sh
#tail -f /usr/local/php/var/log/php-fpm.log
tail -f /var/log/nginx/error.log;
