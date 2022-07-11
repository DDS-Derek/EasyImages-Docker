# 本项目是icret/EasyImages2.0的分支项目，Docker版本的EasyImage

### 中文 | [English](https://github.com/DDSRem/easyimage/blob/master/README-English.md)
## 项目介绍
https://github.com/icret/EasyImages2.0
## 下载
DockerHub https://hub.docker.com/r/ddsderek/easyimage

## 部署

docker-cli-amd64

``` bash 
docker run -itd \
  --name easyimage \
  -p 8080:80 \
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage:latest
```
docker-cli-arm64

```bash
docker run -itd \
  --name easyimage \
  -p 8080:80 \
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage:latest-arm64
```

docker-compose-amd64

```bash
version: '3.3'
services:
  easyimage:
    image: ddsderek/easyimage:latest
    container_name: easyimage
    ports:
      - '8080:80'
    volumes:
      - '/root/data/docker_data/easyimage/config:/app/web/config'
      - '/root/data/docker_data/easyimage/i:/app/web/i'
    restart: unless-stopped
```
docker-compose-arm64

```bash
version: '3.3'
services:
  easyimage:
    image: ddsderek/easyimage:latest-arm64
    container_name: easyimage
    ports:
      - '8080:80'
    volumes:
      - '/root/data/docker_data/easyimage/config:/app/web/config'
      - '/root/data/docker_data/easyimage/i:/app/web/i'
    restart: unless-stopped
```

## 更新

docker-cli-amd64

```
docker stop easyimage
docker rm easyimage
docker image rm easyimage
docker run -itd \
  --name easyimage \
  -p 8080:80 \
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage:latest
docker exec -it easyimage rm -rf /app/web/install
```

docker-cli-arm64

```
docker stop easyimage
docker rm easyimage
docker image rm easyimage
docker run -itd \
  --name easyimage \
  -p 8080:80 \
  -v /root/data/docker_data/easyimage/config:/app/web/config \
  -v /root/data/docker_data/easyimage/i:/app/web/i \
  ddsderek/easyimage:latest-arm64
docker exec -it easyimage rm -rf /app/web/install
```

docker-compose(通用)

```
docker-compose pull
docker-compose up -d
docker exec -it easyimage rm -rf /app/web/install
```

## 版本更新

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

项目作者:https://github.com/icret/EasyImages2.0

dockerfile环境配置参考:https://hub.docker.com/r/taobig/nginx-php74
