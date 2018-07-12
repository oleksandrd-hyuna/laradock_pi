if [ ! -d "vendor" ]; then
    composer install
    chmod 777 -R vendor
    chown laradock:laradock -R vendor
fi

export USER=uadev
supervisord --nodaemon -c /etc/supervisor/supervisord.conf
# service sendmail restart