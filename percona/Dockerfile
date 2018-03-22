FROM percona:5.7
RUN echo ========PERCONA_INSTALLING================================================
LABEL maintainer="DTUNES <diegotdai@gmai.com>"

RUN chown -R mysql:root /var/lib/mysql/

ADD my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
