# Docker-nginx-http-flv
Docker image for an HTTP FLV server running on nginx

* NGINX Version 1.21.1
* [nginx-http-flv-module](https://github.com/winshining/nginx-http-flv-module) Version 1.2.9

## Configurations
This image exposes port 1935 for RTMP Steams and has 1 default channel open "live".

live (or your first stream name) is also accessable via HTTP-FLV on port 8080

It also exposes 8080 so you can access http://<your server ip>:8080/stat to see the streaming statistics.

The configuration file is in /opt/nginx/conf/

## Running

### Docker Container

To run the container and bind the port 1935 to the host machine; run the following:
```
docker run -d -p 1935:1935 -p 8080:8080 lewangdev/nginx-http-flv
```

### OBS

Start streaming

![OBS](https://github.com/lewangdev/docker-nginx-http-flv/blob/main/images/obs.png?raw=true)

### flv.js

Open the stream by localhost [flv.js](https://github.com/Bilibili/flv.js/)

![flv.js](https://github.com/lewangdev/docker-nginx-http-flv/blob/main/images/flvjs.png?raw=true)


### Feedback

[GitHub Issues](https://github.com/lewangdev/docker-nginx-http-flv/issues)