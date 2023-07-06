server {
        server_name {{ notifications_domain }};


        location / {
                proxy_pass         http://127.0.0.1:{{ notifications_nostr_listen_address }}/;
                proxy_redirect     off;

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
}
server {
        if ($host = {{ notifications_domain }}) {
                return 301 https://$host$request_uri;
        }
}
