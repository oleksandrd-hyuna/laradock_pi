FROM mariadb:latest
RUN echo ========MARIA_DB_INSTALLING================================================
LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

ADD my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
