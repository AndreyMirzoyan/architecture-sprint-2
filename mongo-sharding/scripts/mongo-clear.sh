#!/bin/bash

# ###
# # Очищаем данные в helloDoc
# ###

green=$(tput setaf 2)
normal=$(tput sgr0)


printf "${green}\n\nRemove test data...\n${normal}"

docker compose exec -T mongos_router mongosh --quiet --port 27020 <<EOF
use megadb
db.helloDoc.deleteMany({})
EOF