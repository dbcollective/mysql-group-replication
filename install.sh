#!/bin/bash

[ -d ./data/node1 -a -d ./data/node2 -a -d ./data/node3 ] && { echo "Already Installed :(.."; exit 1; }

if [ ! -f ".env" ]
then
   read -p ".env file is not available. Do you want to copy the default one (y|n)? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi
    cp -i .env.example .env
fi

set -o allexport
source .env
set +o allexport

docker-compose down --remove-orphans -v
rm -rf ./data
chmod +x mysql.sh
docker-compose build
docker-compose up -d

for N in 1 2 3
do until docker-compose exec node1 /bin/bash -c 'export MYSQL_PWD='$MYSQL_ROOT_PASSWORD'; mysql -h server'$N' -u root -e ";"'
    do
        echo "Waiting for node$N database connection..."
        sleep 4
    done
    echo -e "\nnode$N server is connected :)"
done

docker-compose exec node1 /bin/bash -c 'export MYSQL_PWD='$MYSQL_ROOT_PASSWORD'; mysql -h server1 -u root -e "use '$MYSQL_DATABASE'; CALL set_as_master;"'
for N in 2 3
do docker-compose exec node$N /bin/bash -c 'export MYSQL_PWD='$MYSQL_ROOT_PASSWORD'; mysql -h server'$N' -u root -e "use '$MYSQL_DATABASE'; CALL set_as_slave;"'
done

docker-compose exec node1 /bin/bash -c 'export MYSQL_PWD='$MYSQL_ROOT_PASSWORD'; mysql -h server'$N' -u root -e "use '$MYSQL_DATABASE'; SELECT * FROM performance_schema.replication_group_members;"'