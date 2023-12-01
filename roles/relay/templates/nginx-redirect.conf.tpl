resolver 8.8.8.8;

error_log /dev/stdout;
access_log /dev/stdout;

gzip on;
gzip_proxied any;
gzip_types text/plain text/css application/json application/javascript;

server {
    listen       80;
    server_name  host.docker.internal;

    location ~* ^/(.*) {
        proxy_set_header Host nos-relay.webflow.io;
        proxy_ssl_server_name on;
        proxy_pass https://nos-relay.webflow.io$request_uri;
    }
}