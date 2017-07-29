# docker-octoprint

This container has baseline support for [OctoPrint](http://octoprint.org/) and optional support for webcams and [CuraEngine](https://github.com/Ultimaker/CuraEngine).

## Exposed ports

  - `5000`: OctoPrint http host
  - `8088`: mjpg-streamer http host

## Volumes

`/var/local/octoprint`–used for OctoPrint configs.

## Sharing printer with container

Sharing with the container is done via `--device`-argument when running the container: `--device /dev/ttyACM0:/dev/ttyACM0` (path to your printer may vary)

## CuraEngine

OctoPrint has built-in plugin support for CuraEngine, but the path still needs to be added via UI or config:

```yaml
plugins:
  cura:
    cura_engine: /usr/local/curaengine/curaengine
```

## Webcam support (optional)

Support is achieved using [mjpg-streamer](https://github.com/jacksonliam/mjpg-streamer). This requires a couple steps. First, the video-device on the host needs to be bound to the container. Second, the webcam-settings need be added via UI or config:

### Docker config

Add argument when running container: `--device=/dev/video0:/dev/videoX` where `/dev/videoX` is the path to the device on the host.

### OctoPrint config

*[avconv](https://libav.org/avconv.html) is also pre-installed to allow for timelapse capture.*

```yaml
webcam:
  ffmpeg: /usr/bin/avconv
  snapshot: http://<host-ip:port>/?action=snapshot
  stream: http://<host-ip:port>/?action=stream
```