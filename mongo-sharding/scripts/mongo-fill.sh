#!/bin/bash

# ###
# # Заполняем тестовые данные в helloDoc
# ###

green=$(tput setaf 2)
normal=$(tput sgr0)


printf "${green}\n\nFill test data...\n${normal}"

docker compose exec -T mongos_router mongosh --quiet --port 27004 <<EOF
use megadb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
EOF

