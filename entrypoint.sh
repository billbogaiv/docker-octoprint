#!/bin/sh

set -e${SET_FLAGS}

cameraDevicePath="/dev/video0"
streamerInputOptions=${STREAMER_INPUT_OPTIONS}

if [ -e ${cameraDevicePath} ]; then
    mjpg_streamer -i "/usr/local/lib/mjpg-streamer/input_uvc.so ${streamerInputOptions} -d ${cameraDevicePath}" -o "/usr/local/lib/mjpg-streamer/output_http.so -p 8088" &
else
    echo "Path to camera not found: ${cameraDevicePath}. If you are trying to capture video, please make sure this path is properly mapped when running the container."
fi

exec octoprint serve --iknowwhatimdoing --basedir "/var/local/octoprint"