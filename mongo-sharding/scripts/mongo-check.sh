#!/bin/bash

# ###
# # Проверяем тестовые данные в helloDoc
# ###

green=$(tput setaf 2)
normal=$(tput sgr0)


printf "${green}\n\nCheck router...\n${normal}"

docker compose exec -T mongos_router mongosh --quiet --port 27004 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF


printf "${green}\n\nCheck shard 1...\n${normal}"

docker compose exec -T shard1 mongosh --quiet --port 27011 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF


printf "${green}\n\nCheck shard 2...\n${normal}"

docker compose exec -T shard2 mongosh --quiet --port 27021 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF

