#!/bin/bash

function getImageHash() {
    docker inspect {{ service_image }}:{{ service_image_tag }} --format "{{ '{{ .Id }}' }}"
}

currentHash=$(getImageHash)

docker compose pull && docker compose up -d

newHash=$(getImageHash)

if [[ "$currentHash" != "$newHash" ]]; then
    echo "updated service to image id $newHash"
    echo "pruning dangling and unused images"
    docker system prune --all --force
fi
