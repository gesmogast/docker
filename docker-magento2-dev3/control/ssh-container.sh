#!/bin/bash
# Use script argument to point docker container you want ssh to like that:
# ./ssh-container.sh db
# Resolving container name
containername=$(docker ps --filter "name=magento" | awk '{if(NR>1) print $NF}' | grep $1)
# Executing bash shell in the container
docker exec -i -t $containername bash
