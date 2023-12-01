resolver 8.8.8.8;

error_log /dev/stdout;
access_log /dev/stdout;

server {
    listen       80;
    server_name  host.docker.internal;

    location / {
        proxy_ssl_server_name on;
        proxy_set_header Host {{ domain }};
        proxy_pass https://nos-relay.webflow.io$request_uri;

        add_header X-Frame-Options "SAMEORIGIN";
        add_header X-Content-Type-Options nosniff;
        add_header Content-Security-Policy "default-src 'self'";
    }

    proxy_connect_timeout       300;
    proxy_send_timeout          300;
    proxy_read_timeout          300;
    send_timeout                300;
}