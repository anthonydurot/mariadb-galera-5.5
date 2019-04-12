FROM ubuntu:trusty


RUN groupadd -r mysql && useradd -r -g mysql mysql \
    && apt-get update \
    && apt install -q -y software-properties-common \
    && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db \
    && add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mariadb.mirrors.ovh.net/MariaDB/repo/5.5/ubuntu trusty main' \
    && apt-get update \
    && apt-get install -q -y mariadb-galera-server mariadb-client galera \
    && rm -rf /var/lib/apt/lists/* \\

VOLUME ["/var/lib/mysql", "/etc/mysql/conf.d"]

COPY docker-entrypoint.sh /usr/local/bin

RUN chmod +x /docker-entrypoint.sh \
    && ln -s usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 4567 4444 4568

CMD ["mysqld"]