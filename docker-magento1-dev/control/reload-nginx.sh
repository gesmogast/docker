#!/bin/bash
containername=$(docker ps --filter "name=magento_1" | awk '{if(NR>1) print $NF}')
docker exec -i -t $containername service nginx reload
