#!/usr/bin/env bash


ROLE="${ROLE:-server}";


if [ "$ROLE" = "server" ]; then

    echo  " "
    echo  " L A R A V E L   S E R V E R "
    echo  " "
    exec php-fpm;

elif [ "$ROLE" = "queue" ]; then

    echo  " "
    echo  "  L A R A V E L   Q U E U E "
    echo  " "
    exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf;

elif [ "$ROLE" = "scheduler" ]; then

    echo  " "
    echo  "  L A R A V E L   S C H E D U L E R "
    echo  " "
    scheduler.sh "php /var/www/artisan schedule:run --verbose --no-interaction"

else
    echo "Could not match the container role \"$ROLE\""
    exit 1
fi



