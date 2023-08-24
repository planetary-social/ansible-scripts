#!/bin/bash

currentHash=$(docker inspect {{ nostrface_image }}:{{ nostrface_image_tag }} --format "{{ '{{ .Id }}' }}")

docker-compose pull -q

newHash=$(docker inspect {{ nostrface_image }}:{{ nostrface_image_tag }} --format "{{ '{{ .Id }}' }}")

if [[ "$currentHash" != "$newHash" ]]; then
        docker-compose down
        docker-compose up -d
        echo "updated service to image id $newHash"
fi
