#############################################################################
#                               Wordpress1                                  #
#############################################################################
server {
    listen            80;
    listen       [::]:80;
    server_name  wordpress1.yphanikumar.xyz;

    location / {
    resolver kube-dns.kube-system.svc.cluster.local ipv6=off;
    set $target http://wordpress-1.dev.svc.cluster.local:80;
    proxy_pass  $target;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    proxy_redirect off;
    proxy_buffering off;
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
   }
  # force https-redirects
    if ($http_x_forwarded_proto = 'http'){
    return 301 https://$host$request_uri;
    }
}

#############################################################################
#                               Wordpress2                                  #
#############################################################################
server {
    listen            80;
    listen       [::]:80;
    server_name  wordpress2.yphanikumar.xyz;

    location / {
    resolver kube-dns.kube-system.svc.cluster.local ipv6=off;
    set $target http://wordpress-2.dev.svc.cluster.local:80;
    proxy_pass  $target;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    proxy_redirect off;
    proxy_buffering off;
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
   }
  # force https-redirects
    if ($http_x_forwarded_proto = 'http'){
    return 301 https://$host$request_uri;
    }
}
#############################################################################
#                               Dashboard                                   #
#############################################################################
server {
    listen            80;
    listen       [::]:80;
    server_name  dashboard.yphanikumar.xyz;

    location / {
    resolver kube-dns.kube-system.svc.cluster.local ipv6=off;
    set $target https://kubernetes-dashboard.kube-system.svc.cluster.local:8443;
    proxy_pass  $target;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    proxy_redirect off;
    proxy_buffering off;
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
   }
  # force https-redirects
    if ($http_x_forwarded_proto = 'http'){
    return 301 https://$host$request_uri;
    }
}

#############################################################################
#                               Rancher                                     #
#############################################################################
server {
    listen            80;
    listen       [::]:80;
    server_name  rancher.yphanikumar.xyz;

    location / {
   # resolver kube-dns.kube-system.svc.cluster.local ipv6=off;
    set $target https://35.221.53.20:443;
    proxy_pass  $target;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    proxy_redirect off;
    proxy_buffering off;
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
   }
  # force https-redirects
    if ($http_x_forwarded_proto = 'http'){
    return 301 https://$host$request_uri;
    }
}
