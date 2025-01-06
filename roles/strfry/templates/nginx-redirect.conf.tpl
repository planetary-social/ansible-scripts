resolver 8.8.8.8 ipv6=off;

error_log /dev/stdout;
access_log /dev/stdout;

server {
    listen       80;
    server_name  host.docker.internal;

    location ~* ^/(.*) {
        proxy_pass https://nos-relay.webflow.io$request_uri;
        proxy_ssl_server_name on;
        proxy_ssl_protocols TLSv1.2 TLSv1.3;

        proxy_set_header Host nos-relay.webflow.io;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}