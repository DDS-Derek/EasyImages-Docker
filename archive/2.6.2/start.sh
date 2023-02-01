#!/bin/bash
if [ ! -f "/data/wwwroot/config/config.php" ]; then
 echo "配置文件不存在，正在创建" && \
 mv /config/api_key.php /data/wwwroot/config
 mv /config/config.guest.php /data/wwwroot/config
 mv /config/config.manager.php /data/wwwroot/config
 mv /config/config.php /data/wwwroot/config
 mv /i/.htaccess /data/wwwroot/i
 mv /i/index.html /data/wwwroot/i
 chown -R www:www /data/wwwroot
else
 echo "配置文件存在" && 
 rm -rf /config/
 rm -rf /i/
 chown -R www:www /data/wwwroot
fi

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf 
else     
exec "$@" 
fi