#!/bin/bash
if [ ! -f "/data/wwwroot/config/config.php" ]; then
 echo "配置文件不存在，正在创建" && \
 wget https://raw.githubusercontent.com/DDSRem/easyimage/master/config/api_key.php -P /data/wwwroot/config && \
 wget https://raw.githubusercontent.com/DDSRem/easyimage/master/config/config.guest.php -P /data/wwwroot/config && \
 wget https://raw.githubusercontent.com/DDSRem/easyimage/master/config/config.manager.php -P /data/wwwroot/config && \
 wget https://raw.githubusercontent.com/DDSRem/easyimage/master/config/config.php -P /data/wwwroot/config && \
 wget https://raw.githubusercontent.com/DDSRem/easyimage/master/i/.htaccess -P /data/wwwroot/i && \
 wget https://raw.githubusercontent.com/DDSRem/easyimage/master/i/index.html -P /data/wwwroot/i && \
 chown -R www:www /data/wwwroot
else
 echo "配置文件存在" && chown -R www:www /data/wwwroot
fi

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf 
else     
exec "$@" 
fi