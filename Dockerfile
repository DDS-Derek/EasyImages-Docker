FROM ddsderek/foundations:Ubuntu20.04-nginx1.16.1-php7.4.20-nostart

ENV TAG=2.6.5

COPY start.sh /

WORKDIR /opt

RUN apt-get update && \
    apt-get install -y wget zip && \
    wget https://github.com/icret/EasyImages2.0/archive/refs/tags/${TAG}.zip && \
    unzip ${TAG}.zip && \
    mv /opt/EasyImages2.0-${TAG} /opt/web && \
    cp -r /opt/web /app && \
    cp -r /opt/web/config / && \
    cp -r /opt/web/i / && \
    rm -rf /opt && \
    apt-get remove -y wget zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod 755 /start.sh

WORKDIR /app/web

CMD [ "/start.sh" ]