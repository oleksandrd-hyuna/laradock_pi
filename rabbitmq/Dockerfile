FROM rabbitmq
RUN echo ========RABBIT_MQ_INSTALLING================================================
LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

RUN rabbitmq-plugins enable --offline rabbitmq_management

EXPOSE 15671 15672
