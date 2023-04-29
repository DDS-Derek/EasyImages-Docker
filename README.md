# EasyImage Docker

## 项目介绍
https://github.com/icret/EasyImages2.0

DockerHub: https://hub.docker.com/r/ddsderek/easyimage

## 部署

docker-cli

``` bash 
docker run -itd \
  --name easyimage \
  -p 8080:80 \
  -e TZ=Asia/Shanghai \
  -e PUID=1000 \
  -e PGID=1000 \
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage:latest
```

docker-compose

```yaml
version: '3.3'
services:
  easyimage:
    image: ddsderek/easyimage:latest
    container_name: easyimage
    ports:
      - '8080:80'
    environment:
      - TZ=Asia/Shanghai
      - PUID=1000
      - PGID=1000
    volumes:
      - '/root/data/docker_data/easyimage/config:/app/web/config'
      - '/root/data/docker_data/easyimage/i:/app/web/i'
    restart: unless-stopped
```

## 更新

docker-cli

```bash
docker stop easyimage
docker rm easyimage
docker image rm easyimage
docker run -itd \
  --name easyimage \
  -p 8080:80 \
  -e TZ=Asia/Shanghai \
  -e PUID=1000 \
  -e PGID=1000 \
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage:latest
```

docker-compose

```bash
docker-compose pull
docker-compose up -d
```

## 更新日志

- v2.8.1-r1 **正式版** 重写Dokcer镜像，开启Opcache
- v2.8.1 **正式版** 同步更新v2.8.1
- v2.8.0 **正式版** 同步更新v2.8.0
- v2.7.9 **正式版** 同步更新v2.7.9
- v2.7.7 **正式版** 同步更新v2.7.7
- v2.7.6-r1 **正式版** 修复manag.php文件不存在的bug。
- v2.7.6 **正式版** 同步更新v2.7.6
- v2.7.5 **正式版** 同步更新v2.7.5
- v2.7.0 **正式版** Synchronous update v2.7.0 & archive & Optimize log output & configuration file creation & Optimize installation judgment
- v2.6.9 **正式版** 同步更新v2.6.9
- v2.6.8 **正式版** 同步更新v2.6.8
- 2.6.7 **正式版** 同步更新2.6.7  统一镜像
- 2.6.6.8 **正式版** 增加PUID PGID TZ变量
- 2.6.6.7 **正式版** 增加linux/ppc64le，linux/386镜像
- 2.6.6.6 **正式版** 增加linux/arm/v6，linux/arm/v7，linux/arm64/v8，linux/s390x镜像
- 2.6.6.5 **正式版** 分离amd64和arm64镜像
- 2.6.6.2 **正式版** 支持arm
- 2.6.5.3 **正式版** 更改PHP最大上传: 512M 更改POST最大上传: 512M 更改Nginx上传限制: 512M
- 2.6.5.2 **正式版** 更改Dockerfile文件，使用全新制作流程
- 2.6.5.1 **正式版** 修复最大上传20M问题
- 2.6.5.0 **正式版** 同步更新2.6.5 
- 2.6.4 **Beta测试版** 同步更新2.6.4
- 2.6.2.1 **正式版** 同步更新2.6.2
- 2.6.2 **Beta测试版** 同步更新2.6.2
- 2.6.1 **Beta测试版** 同步更新2.6.2

## 感谢

项目作者: https://github.com/icret/EasyImages2.0
