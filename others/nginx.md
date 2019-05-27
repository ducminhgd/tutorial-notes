# Nginx

## Caching

Sample configuration

```shell
proxy_cache_path /tmp/cache/web keys_zone=web_cache:20m loader_threshold=500 loader_files=200;

# Set a cache loader with:
# - Cached files are stored in `/tmp/cache/web` directory
# - Name of this loader is `web_cache` and it is allowed 20MB for caching.
# - Duration of an iteration: 500 milliseconds.
# - Maximum number of items loaded during one iteration: 200 items/files.

server {
        listen       80;
        server_name  local.web.example.com;

        #   Logs
        access_log  /var/log/nginx/local.web.example.com.access.log;
        error_log   /var/log/nginx/local.web.example.com.error.log;

        location = /50x.html {
            root   /usr/share/nginx/html;
        }

        proxy_cache_key "$request_method$host$request_uri"; # Cache key, for example: `GETlocal.web.example.com/api/?t=1000`
        proxy_cache_min_uses 2; # Cache URL with 2 or more requests only.
        proxy_cache_methods GET; # Cache GET requests only.
        proxy_cache_valid 200 302 1m; # For responses with HTTP status code is 200 or 302, cached response in 1 minute.
        proxy_cache_valid 404 5s; # For responses with HTTP status code is 400, cached response in 5 seconds
        proxy_cache_bypass $cookie_nocache $arg_nocache$arg_comment; # Nocache conditions

        location / {
            proxy_cache pvis_cache; # Choose which cache loader to use

            proxy_read_timeout 600s;

            proxy_set_header  Host $host;
            proxy_set_header  X-Real-IP $remote_addr;
            proxy_set_header  X-Forwarded-Proto $scheme;
            proxy_set_header  X-Forwarded-For $remote_addr;
            proxy_set_header  X-Forwarded-Host $remote_addr;

            proxy_http_version 1.1;
            proxy_set_header Connection "";
        }
}
```
