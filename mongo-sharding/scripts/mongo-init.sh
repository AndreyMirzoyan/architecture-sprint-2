#!/bin/bash

# ###
# # Инициализируем бд
# ###

green=$(tput setaf 2)
normal=$(tput sgr0)


printf "${green}\n\nInit configSrv...\n${normal}"

docker compose exec -T configSrv mongosh --quiet  <<EOF
rs.initiate(
    {
        _id : "config_server",
        configsvr: true,
        members: [
            { _id : 0, host : "configSrv:27017" }
        ]
    }
);
EOF



printf "${green}\n\nInit shard #1...\n${normal}"

docker compose exec -T shard1 mongosh --quiet --port 27018 <<EOF
rs.initiate(
    {
        _id : "shard1",
        members: [
            { _id : 0, host : "shard1:27018" },
        ]
    }
);
EOF



printf "${green}\n\nInit shard #2...\n${normal}"

docker compose exec -T shard2 mongosh --quiet --port 27019 <<EOF
rs.initiate(
    {
        _id : "shard2",
        members: [
            { _id : 1, host : "shard2:27019" }
        ]
    }
);
EOF



printf "${green}\n\nInit router...\n${normal}"

docker compose exec -T mongos_router mongosh --quiet  --port 27020 <<EOF
sh.addShard("shard1/shard1:27018");
sh.addShard("shard2/shard2:27019");

sh.enableSharding("megadb");
sh.shardCollection("megadb.helloDoc", { "name" : "hashed" } )
EOF

