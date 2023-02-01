#!/bin/bash

if [ ! -f "/app/web/config/config.php" ]; then
    echo -e "\033[36m config.php文件不存在,正在创建... \033[0m"
    cp /config/config.php /app/web/config/config.php
    if [ -f "/app/web/config/config.php" ]; then
        echo "config.php文件创建成功"
    else
        echo "config.php文件创建失败"
        exit 1
    fi
else
    echo "config.php文件存在"
fi

if [ ! -f "/app/web/config/api_key.php" ]; then
    echo -e "\033[36m api_key.php文件不存在,正在创建... \033[0m"
    cp /config/api_key.php /app/web/config/api_key.php
    if [ -f "/app/web/config/api_key.php" ]; then
        echo "api_key.php文件创建成功"
    else 
        echo "api_key.php文件创建失败"
        exit 1
    fi
else
    echo "api_key.php文件存在"
fi

if [ ! -f "/app/web/config/config.guest.php" ]; then
    echo -e "\033[36m config.guest.php文件不存在,正在创建... \033[0m"
    cp /config/config.guest.php /app/web/config/config.guest.php
    if [ -f "/app/web/config/config.guest.php" ]; then
        echo "config.guest.php文件创建成功"
    else
        echo "config.guest.php文件创建失败"
        exit 1
    fi
else
    echo "config.guest.php文件存在"
fi

if [ ! -f "/app/web/config/config.manager.php" ]; then
    echo -e "\033[36m config.manager.php文件不存在,正在创建... \033[0m"
    cp /config/config.manager.php /app/web/config/config.manager.php
    if [ -f "/app/web/config/config.manager.php" ]; then
        echo "config.manager.php文件创建成功"
    else
        echo "config.manager.php文件创建失败"
        exit 1
    fi
else
    echo "config.manager.php文件存在"
fi

if [ ! -f "/app/web/i/.htaccess" ]; then
    echo -e "\033[36m .htaccess文件不存在,正在创建... \033[0m"
    cp /i/.htaccess /app/web/i/.htaccess
    if [ -f "/app/web/i/.htaccess" ]; then
        echo ".htaccess文件创建成功"
    else
        echo ".htaccess文件创建失败"
        exit 1
    fi
else
    echo ".htaccess文件存在"
fi

if [ ! -f "/app/web/i/index.html" ]; then
    echo -e "\033[36m index.html文件不存在,正在创建... \033[0m"
    cp /i/index.html /app/web/i/index.html
    if [ -f "/app/web/i/index.html" ]; then
        echo "index.html文件创建成功"
    else
        echo "index.html文件创建失败"
        exit 1
    fi
else
    echo "index.html文件存在"
fi