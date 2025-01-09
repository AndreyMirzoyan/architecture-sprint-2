#!/bin/bash

echo
echo "Init config server"
echo

while ! mongosh --quiet --host configSrv --port 27003 <<EOF
rs.initiate(
    {
        _id : "config_server",
        configsvr: true,
        members: [
            { _id : 0, host : "configSrv:27003" }
        ]
    }
);
EOF
do
    echo waiting 1s
    sleep 1
done


echo
echo "Init shard #1"
echo

while ! mongosh --host shard11 --quiet --port 27011 <<EOF
rs.initiate(
    {
        _id : "rs0",
        members: [
            { _id : 0, host : "shard11:27011", priority: 4 },
            { _id : 1, host : "shard12:27012", priority: 3 },
            { _id : 2, host : "shard13:27013", priority: 2 },
            { _id : 3, host : "shard14:27014", priority: 1 },
        ]
    }
);
EOF
do
    echo waiting 1s
    sleep 1
done

echo
echo "Init shard #2"
echo

while ! mongosh --host shard21 --quiet --port 27021 <<EOF
rs.initiate(
    {
        _id : "rs1",
        members: [
            { _id : 4, host : "shard21:27021", priority: 4 },
            { _id : 5, host : "shard22:27022", priority: 3 },
            { _id : 6, host : "shard23:27023", priority: 2 },
            { _id : 7, host : "shard24:27024", priority: 1 },
        ]
    }
);
EOF
do
    echo waiting 1s
    sleep 1
done


echo
echo Init router
echo

while ! mongosh --host mongos_router --quiet  --port 27004 <<EOF
sh.addShard("rs0/shard11:27011");
sh.addShard("rs1/shard21:27021");

sh.enableSharding("megadb");
sh.shardCollection("megadb.helloDoc", { "name" : "hashed" } )
EOF
do
    echo waiting 1s
    sleep 1
done

