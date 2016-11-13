NGINX RTMP Dockerfile
=====================

Forked from (nginx-rtmp-dockerfile by brocaar)[https://github.com/brocaar/nginx-rtmp-dockerfile].

This Dockerfile installs NGINX configured with `nginx-rtmp-module`, ffmpeg
and some default settings for HLS live streaming.

This forked version also generate thumbnail using (hls-thumbnail-generator by tjenkinson)[https://github.com/tjenkinson/hls-live-thumbnails/] by default.

**Note: in the current state, this is just an experimental project to play with
RTMP and HLS.**


How to use
----------

1. Build and run the container (`docker build -t nginx_rtmp .` &
   `docker run -p 1935:1935 -p 8080:80 --rm nginx_rtmp`).

2. Stream your live content to `rtmp://localhost:1935/encoder/stream_name` where
   `stream_name` is the name of your stream.

3. In Safari, VLC or any HLS compatible browser / player, open
   `http://localhost:8080/hls/stream_name.m3u8`. Note that the first time,
   it might take a few (10-15) seconds before the stream works. This is because
   when you start streaming to the server, it needs to generate the first
   segments and the related playlists.

4. Thumbnail will be generated inside the container in `/data/hls/thumbnail/stream_name`


Links
-----

* http://nginx.org/
* https://github.com/arut/nginx-rtmp-module
* https://github.com/brocaar/nginx-rtmp-dockerfile
* https://github.com/tjenkinson/hls-live-thumbnails/
* https://www.ffmpeg.org/
* https://obsproject.com/
