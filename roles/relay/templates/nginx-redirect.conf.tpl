resolver 8.8.8.8;

server {
    listen       80;
    server_name host.docker.internal;

    location / {
        proxy_ssl_server_name on;
        proxy_set_header Host {{ domain }};
        proxy_pass https://nos-relay.webflow.io$request_uri;
    }
}
