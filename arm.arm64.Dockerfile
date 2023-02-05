FROM ddsderek/foundations:Ubuntu20.04-nginx1.18.0-php7.4-apt

ENV TAG=2.7.3

ADD ./shell /shell

WORKDIR /opt

RUN wget --no-check-certificate https://github.com/icret/EasyImages2.0/archive/refs/tags/${TAG}.zip && \
    unzip ${TAG}.zip && \
    mv /opt/EasyImages2.0-${TAG} /opt/web && \
    wget --no-check-certificate https://github.com/lionsoul2014/ip2region/raw/master/data/ip2region.xdb -O /opt/web/application/ip2region/ip2region.xdb && \
    cp -r /opt/web /app && \
    cp -r /opt/web/config / && \
    cp -r /opt/web/i / && \
    rm -rf /opt && \
    apt-get remove -y wget zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod -R 755 /shell

WORKDIR /app/web
