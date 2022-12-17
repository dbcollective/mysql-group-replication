#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo 'Too many/few arguments, expecting one' >&2
    exit 1
fi

case $1 in
    boot)
        docker-compose down && docker-compose up -d ;;
    start)
        docker-compose up -d ;;
    restart)
        docker-compose restart ;;
    stop)
        docker-compose down ;;
    node1|node2|node3)
        set -o allexport
        source .env
        set +o allexport
        docker-compose exec -it $1 /bin/bash -c 'export MYSQL_PWD='$MYSQL_ROOT_PASSWORD'; mysql -u root' ;;
    *)
        # The wrong first argument.
        echo 'Expected "start", "restart", "stop", "boot", "node1", "node2" or "node3"' >&2
        exit 1
esac