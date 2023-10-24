#!/bin/bash

currentHash=$(docker inspect cooldracula/rsslay:stable --format "{{ .Id }}")

docker compose pull -q

newHash=$(docker inspect cooldracula/rsslay:stable --format "{{ .Id }}")

if [[ "$currentHash" != "$newHash" ]]; then
        docker compose down
        docker compose up -d
        echo "updated service to image id $newHash"
fi
