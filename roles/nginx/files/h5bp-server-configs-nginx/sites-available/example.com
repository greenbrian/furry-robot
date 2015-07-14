
server {
    listen 80;
    server_name firstsite.com www.firstsite.com;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /var/furry-robot;
    }

    location / {
        include         uwsgi_params;
        uwsgi_pass      unix:/var/furry-robot/furry-robot.sock;
    }
}
