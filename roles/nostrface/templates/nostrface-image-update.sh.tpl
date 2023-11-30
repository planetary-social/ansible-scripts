#!/bin/bash

function getImageHash() {
  docker inspect {{ nostrface_image }}:{{ nostrface_image_tag }} --format "{{ '{{ .Id }}' }}"
}

currentHash=$(getImageHash)

docker-compose pull && docker-compose up -d

newHash=$(getImageHash)

if [[ "$currentHash" != "$newHash" ]]; then
        echo "updated service to image id $newHash"
fi
