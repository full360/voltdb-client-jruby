#!/usr/bin/env bash

docker-compose up -d
sleep 5
docker-compose exec voltdb bash -c "echo FILE -BATCH /tmp/helloworld.sql | sqlcmd"
