FROM mongo:latest
RUN echo ========MONGO_DB_INTERFACE_INSTALLING================================================
LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

#COPY mongo.conf /usr/local/etc/mongo/mongo.conf

VOLUME /data/db /data/configdb

CMD ["mongod"]

EXPOSE 27017

