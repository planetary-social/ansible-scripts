resolver 8.8.8.8;

error_log /dev/stdout;
access_log /dev/stdout;

upstream webflow {
    server proxy-ssl.webflow.com:443;
}

server {
    listen       80;
    server_name  host.docker.internal;


    location @webflow {
        proxy_pass                          https://webflow;
        proxy_set_header Host               $host;
        proxy_set_header X-Forwarded-For    $remote_addr;
        proxy_set_header X_FORWARDED_PROTO  https;
        proxy_ssl_verify        off;
        proxy_ssl_session_reuse on;
        proxy_ssl_server_name   on;
        proxy_ssl_name          $host;
    }

    location ~* ^/(.*) {
        try_files /dev/null @webflow;
    }

    location = / {
        try_files /dev/null @webflow;
    }
}

# temporarily forward requests with name subdomains to their njump profile page
server {
    server_name "~^(?<profile>\w+)\.{{ domain }}$";

    location = / {
        return 302 https://njump.me/$profile@nos.social;
    }
}
