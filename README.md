# 本项目是icret/EasyImages2.0的分支项目，Docker版本的EasyImage

### 中文 | [English](https://github.com/DDSRem/easyimage/blob/master/README-English.md)
## 项目介绍
https://github.com/icret/EasyImages2.0
## 下载
DockerHub https://hub.docker.com/r/ddsderek/easyimage

## 部署

docker-cli

``` bash 
docker run -itd \
  --name easyimage \
  -p 8080:80 \
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage
```
docker-compose
```
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
```
## 更新

docker-cli

```
docker stop easyimage
docker rm easyimage
docker image rm easyimage
docker run -itd \
  --name easyimage \
  -p 8080:80 \
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage
docker exec -it easyimage rm -rf /app/web/install
```

docker-compose

```
docker-compose pull
docker-compose up -d
docker exec -it easyimage rm -rf /app/web/install
```

## 版本更新

- 2.6.5.2 **正式版** 更改Dockerfile文件，使用全新制作流程
- 2.6.5.1 **正式版** 修复最大上传20M问题
- 2.6.5.0 **正式版** 同步更新2.6.5 
- 2.6.4 **Beta测试版** 同步更新2.6.4
- 2.6.2.1 **正式版** 同步更新2.6.2
- 2.6.2 **Beta测试版** 同步更新2.6.2
- 2.6.1 **Beta测试版** 同步更新2.6.2

## 感谢

项目作者:https://github.com/icret/EasyImages2.0

dockerfile环境配置参考:https://hub.docker.com/r/taobig/nginx-php74
