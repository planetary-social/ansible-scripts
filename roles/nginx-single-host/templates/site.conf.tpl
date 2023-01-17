# SPDX-FileCopyrightText: 2021 The NGI Pointer Secure-Scuttlebutt Team of 2020/2021
#
# SPDX-License-Identifier: Unlicense
#

upstream frontend {
  server localhost:{{ frontend_port }};
}

upstream room {
  server localhost:{{ room_port }};
}

upstream graphql {
  server localhost:{{ graphql_port }};
}

upstream blob {
  server localhost:{{ graphql_blob_port }};
}

server {
    server_name {{ inventory_hostname }};

    ## There is a lot of redundancy in the props of these location
    ## blocks at this early stage of the config. It is mostly to ensure it
    ## all works.  I wanted to be as explicit in the routes as possible,
    ## though some of these can likely be removed through clever regex.


   ## Route the root path, and all profile paths, to our frontend server
    location  = / {
       proxy_pass http://frontend/;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
       index  index.html index.htm;
       include  /etc/nginx/mime.types;
       try_files $uri $uri/ /index.html;
    }

    location ~ /(profile/.*) {
       proxy_pass http://frontend/$1;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
       index  index.html index.htm;
       include  /etc/nginx/mime.types;
       try_files $uri $uri/ /index.html;
    }

    location  = /index.html {
       proxy_pass http://frontend/;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
    }


    ## Route the admin styling to the room server
    location ~ /assets/((style|fixfouc).css) {
       proxy_pass http://room/assets/$1;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
    }


    ## Anything else in /assets should come from frontend
    location ~ /assets/(.*) {
       proxy_pass http://frontend/assets/$1;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
    }

    ## all graphql paths go to the graphql server
    location  /graphql/ {
       proxy_pass http://graphql/graphql/;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
    }

    ## Any blob request redirects to /blob/get/$request (this is due to how ssb-blob-server is set up)
    location  ~ /blob/(.*) {
       proxy_pass http://blob/get/$1;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
    }

    ## For any other path not yet specified, use the room server.
    location  / {
       proxy_pass http://room;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
    }

    ## TODO: The room server router is set up with bare paths (e.g. /login instead of /login)
    ## Our proxy adds a trailing slash to request. Unless I set ## these routes explicitly,
    ## the login functions won't work. I should be able to fix it with smart nginx, but not today.

    location  ~ /(login|logout)/ {
       proxy_pass http://room/$1;
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-Host $host;
       proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection $connection_upgrade;
    }

    # TODO: https://blog.tarq.io/nginx-catch-all-error-pages/
}

## this server uses the (same) wildcard cert as the one above but uses a regular expression on the hostname
## which extracts the first subdomain which holds the alias and forwards that to the prox_pass server
## This isn't quite working yet, mostly cos we need to know the right place to redirect.
server {
    server_name "~^(?<profile>\w+)\.{{ inventory_hostname|replace(".","\.") }}$";


    location = / {
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
        proxy_set_header X-Forwarded-Proto $scheme;
        # "rewrite" requests with subdomains to the non-wildcard url for alias resolving
        # $is_args$args pass on ?encoding=json if present
        proxy_pass http://frontend/profile/$profile$is_args$args;
    }

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://frontend/;
    }
}
