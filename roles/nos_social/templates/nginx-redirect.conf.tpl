resolver 8.8.8.8;

error_log /dev/stdout;
access_log /dev/stdout;

server {
    listen       80;
    server_name  host.docker.internal;

    location ~* ^/(.*) {
        proxy_pass https://nos_social.webflow.io$request_uri;
    }
}