server {
        server_name {{ rsslay_domain }};


        location / {
                proxy_pass         http://127.0.0.1:{{ rsslay_port }}/;
                proxy_redirect     off;

                proxy_set_header   Host             $host;
                proxy_set_header   X-Real-IP        $remote_addr;
                proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
                proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
                proxy_http_version 1.1;
                proxy_read_timeout 300s;
                proxy_connect_timeout 300s;
                proxy_send_timeout 300s;
                send_timeout 300s;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
        }



        listen 443 ssl; # managed by Certbot
                ssl_certificate /etc/letsencrypt/live/{{ rsslay_domain }}/fullchain.pem; # managed by Certbot
                ssl_certificate_key /etc/letsencrypt/live/{{ rsslay_domain }}/privkey.pem; # managed by Certbot
                include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
                ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
        if ($host = {{ rsslay_domain }}) {
                return 301 https://$host$request_uri;
        }

        server_name {{ rsslay_domain }};
        listen 80;
        return 404; # managed by Certbot
}
