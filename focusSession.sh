#!/bin/bash

SR_TOP_FOLDER_NAME="$HOME/focus_sessions";

SR_MINUTES=${1:-60};
SR_FPM=${2:-60};
SR_INTERVAL=$((60 / $SR_FPM));
SR_START_TIME=$(date '+%H_%M');

sayecho () {
    echo $1;
    say $1;
}

sayecho "Starting $SR_MINUTES minute session";
sayecho "Start time: $SR_START_TIME";
echo "Capture interval: $SR_INTERVAL second(s)";

SR_FOLDER_NAME="$SR_TOP_FOLDER_NAME/session_$SR_START_TIME";
rm -rf $SR_FOLDER_NAME
mkdir $SR_FOLDER_NAME;

captureLoop () {
    local iteration=$1;
    local minute=$(($iteration / $SR_FPM));
    local filename=$(printf '%06d' $iteration);

    if (( $iteration % $SR_FPM == 0 ))
    then
        echo "Elapsed: $minute minutes";
    fi

    screencapture -x "$SR_FOLDER_NAME/$filename.png";
    sleep $SR_INTERVAL;
}

SR_REPEAT_TIMES=$(($SR_MINUTES * $SR_FPM));
for time in $(seq 0 $SR_REPEAT_TIMES); do
    captureLoop $time;
done;

sayecho "Focus session done";

ffmpeg -framerate 30 -pattern_type glob -i "$SR_FOLDER_NAME/*.png" \
    -vf scale=640x480 \
    -c:v libx264 -pix_fmt yuv420p "$SR_FOLDER_NAME.mp4";

rm -rf $SR_FOLDER_NAME;

sayecho "Timelapse ready";

open "$SR_FOLDER_NAME.mp4";