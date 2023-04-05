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

#Our caching proxy setup
proxy_cache_path /var/lib/nginx/cache levels=1:2 keys_zone=coolcache:500m max_size=1g;
proxy_cache_key "$scheme$request_method$host$request_uri$is_args$args";

server {
    server_name {{ inventory_hostname }};
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;

   ## Route the root path, and all profile paths, to our frontend server
    location  = / {
       expires 60m;
       add_header X-Proxy-Cache $upstream_cache_status;
       proxy_cache coolcache;
       proxy_cache_bypass $http_cache_control;
       proxy_pass http://frontend/;
       index  index.html index.htm;
       include  /etc/nginx/mime.types;
       try_files $uri $uri/ /index.html;
    }


    location ~ /(profile/.*) {
       proxy_pass http://frontend/$1;
       index  index.html index.htm;
       include  /etc/nginx/mime.types;
       try_files $uri $uri/ /index.html;
    }

    location ~ /(thread/.*) {
       proxy_pass http://frontend/$1;
       index  index.html index.htm;
       include  /etc/nginx/mime.types;
       try_files $uri $uri/ /index.html;
    }

    location ~ /(follow/.*) {
       add_header X-Proxy-Cache $upstream_cache_status;
       proxy_pass http://frontend/$1;
       index  index.html index.htm;
       include  /etc/nginx/mime.types;
       try_files $uri $uri/ /index.html;
    }

    location  = /index.html {
       expires 60m;
       add_header X-Proxy-Cache $upstream_cache_status;
       proxy_cache coolcache;
       proxy_cache_bypass $http_cache_control;
       proxy_pass http://frontend/;
    }


    ## Route the admin styling to the room server
    location ~ /assets/((style|fixfouc).css) {
       proxy_pass http://room/assets/$1;
    }


    ## Anything else in /assets should come from frontend
    location ~ /assets/(.*) {
       expires 60m;
       proxy_cache coolcache;
       proxy_cache_bypass $http_cache_control;
       proxy_pass http://frontend/assets/$1;
    }

    ## all graphql paths go to the graphql server
    location  /graphql/ {
       proxy_pass http://graphql/graphql/;
       proxy_cache coolcache;
       proxy_cache_bypass $http_cache_control;
    }

    ## all graphql paths go to the graphql server
    location  ~ /blob/(.*) {
       expires 60m;
       proxy_cache coolcache;
       proxy_cache_bypass $http_cache_control;
       add_header X-Proxy-Cache $upstream_cache_status;
       proxy_pass http://blob/get/$1;
    }

    ## For any other path not yet specified, use the room server.
    location  / {
       proxy_pass http://room;
    }

    ## TODO: The room server router is set up with bare paths (e.g. /login instead of /login)
    ## Our proxy adds a trailing slash to request. Unless I set ## these routes explicitly,
    ## the login functions won't work. I should be able to fix it with smart nginx, but not today.

    location  ~ /(login|logout)/ {
       proxy_pass http://room/$1;
    }

    location  /admin/dashboard/ {
       proxy_pass http://room/admin/dashboard;
    }

    # TODO: https://blog.tarq.io/nginx-catch-all-error-pages/


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/{{ inventory_hostname }}/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/{{ inventory_hostname }}/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

## this server uses the (same) wildcard cert as the one above but uses a regular expression on the hostname
## which extracts the first subdomain which holds the alias and forwards that to the prox_pass server

server {
    server_name "~^(?<profile>\w+)\.{{ inventory_hostname|replace(".","\.") }}$";
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/{{ inventory_hostname }}/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/{{ inventory_hostname }}/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


    location = / {
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
        proxy_set_header X-Forwarded-Proto $scheme;
        # "rewrite" requests with subdomains to the non-wildcard url for alias resolving
        # $is_args$args pass on ?encoding=json if present
        return 302 http://{{ inventory_hostname }}/profile/alias/$profile$is_args$args;
    }

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-For $remote_addr:$remote_port;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://room;
    }
}

server {
    if ($host = {{ inventory_hostname }}) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host ~ {{ inventory_hostname }}$) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    listen [::]:80 default_server;
    server_name {{ inventory_hostname }};
    return 404; # managed by Certbot
}
