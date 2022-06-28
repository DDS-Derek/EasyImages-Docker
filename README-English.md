# This project is a branch project of icret/EasyImages2.0, the Docker version of EasyImage

### English | [Chinese](https://github.com/DDSRem/easyimage/blob/master/README.md)

## 1. Project introduction

https://github.com/icret/EasyImages2.0

## 2. Download

DockerHub https://hub.docker.com/r/ddsderek/easyimage

## 3. Deployment

``` bash
docker run -itd \
  --name easyimage \
  -p 8080:80\
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage
````

docker-compose

````
version: '3.3'
services:
  easyimage:
    image: ddsderek/easyimage
    container_name: easyimage
    ports:
      - '8080:80'
    volumes:
      - '/root/data/docker_data/easyimage/config:/app/web/config'
      - '/root/data/docker_data/easyimage/i:/app/web/i'
    restart: unless-stopped
````

## New version update

- 2.6.5.1 **Official version** Fix the problem of maximum upload 20M
- 2.6.5.0 **Official version** Sync update 2.6.5
- 2.6.4 **Beta** Sync Update 2.6.4
- 2.6.2.1 **Official version** Sync update 2.6.2
- 2.6.2 **Beta** Sync Update 2.6.2
- 2.6.1 **Beta** Sync Update 2.6.2

## Grateful

Project author: https://github.com/icret/EasyImages2.0

Dockerfile environment configuration reference: https://hub.docker.com/r/taobig/nginx-php74

