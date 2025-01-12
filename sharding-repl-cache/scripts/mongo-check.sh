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



printf "${green}\n\nCheck shard 1, instance 1...\n${normal}"

docker compose exec -T shard11 mongosh --quiet --port 27011 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF

printf "${green}\n\nCheck shard 1, instance 2...\n${normal}"

docker compose exec -T shard12 mongosh --quiet --port 27012 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF

printf "${green}\n\nCheck shard 1, instance 3...\n${normal}"

docker compose exec -T shard13 mongosh --quiet --port 27013 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF

printf "${green}\n\nCheck shard 1, instance 4...\n${normal}"

docker compose exec -T shard14 mongosh --quiet --port 27014 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF


printf "${green}\n\nCheck shard 2, instance 1...\n${normal}"

docker compose exec -T shard21 mongosh --quiet --port 27021 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF

printf "${green}\n\nCheck shard 2, instance 2...\n${normal}"

docker compose exec -T shard22 mongosh --quiet --port 27022 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF

printf "${green}\n\nCheck shard 2, instance 3...\n${normal}"

docker compose exec -T shard23 mongosh --quiet --port 27023 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF

printf "${green}\n\nCheck shard 2, instance 4...\n${normal}"

docker compose exec -T shard24 mongosh --quiet --port 27024 <<EOF
use megadb;
db.helloDoc.countDocuments();
EOF