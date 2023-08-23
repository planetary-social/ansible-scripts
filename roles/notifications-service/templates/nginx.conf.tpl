server {
        server_name {{ domain }};


        location / {
                proxy_pass         http://127.0.0.1:{{ notifications_nostr_listen_address }}/;
                proxy_redirect     off;

                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";

                proxy_set_header   Host             $host;
                proxy_set_header   X-Real-IP        $remote_addr;
                proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        }
        location /metrics {
                proxy_pass         http://127.0.0.1:{{ notifications_metrics_listen_address }}/metrics;
                proxy_redirect     off;

                proxy_set_header   Host             $host;
                proxy_set_header   X-Real-IP        $remote_addr;
                proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        }

        listen 443 ssl; # managed by Certbot
                ssl_certificate /etc/letsencrypt/live/{{ domain }}/fullchain.pem; # managed by Certbot
                ssl_certificate_key /etc/letsencrypt/live/{{ domain }}/privkey.pem; # managed by Certbot
                include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
                ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
server {
        if ($host = {{ domain }}) {
                return 301 https://$host$request_uri;
        }

        server_name {{ domain }};
        listen 80;
        return 404; # managed by Certbot
}
