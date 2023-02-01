FROM ddsderek/foundations:Ubuntu20.04-nginx1.16.1-php7.4.20

ADD ./shell /shell

WORKDIR /opt

RUN apt-get update -y && \
    apt-get install -y git && \
    git clone https://github.com/icret/EasyImages2.0.git /opt/web && \
    wget https://github.com/lionsoul2014/ip2region/raw/master/data/ip2region.xdb -O /opt/web/application/ip2region/ip2region.xdb && \
    rm -rf /opt/web/.git /opt/web/.github && \
    cp -r /opt/web /app && \
    cp -r /opt/web/config / && \
    cp -r /opt/web/i / && \
    rm -rf /opt && \
    apt-get remove -y wget zip git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod -R 755 /shell

WORKDIR /app/web
