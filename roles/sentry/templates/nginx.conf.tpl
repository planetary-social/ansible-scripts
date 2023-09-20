server {
        server_name {{ inventory_hostname }};


        location / {
                proxy_pass         http://127.0.0.1:{{ sentry_port }}/;
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
                
                client_max_body_size 1000M;
        }



        listen 443 ssl; # managed by Certbot
                ssl_certificate /etc/letsencrypt/live/{{ inventory_hostname }}/fullchain.pem; # managed by Certbot
                ssl_certificate_key /etc/letsencrypt/live/{{ inventory_hostname }}/privkey.pem; # managed by Certbot
                include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
                ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
        if ($host = {{ inventory_hostname }}) {
                return 301 https://$host$request_uri;
        }

        server_name {{ inventory_hostname }};
        listen 80;
        return 404; # managed by Certbot
}
