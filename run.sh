#!/bin/bash

# Get connected monitors info using xrandr and filter with awk
monitor_info=$(xrandr --query --verbose | awk '/ connected/{print $1,$3,$4,$5,$6}')

# Loop through each line of monitor info
while IFS= read -r line; do
    if [[ $line =~ primary ]]; then
        # Extract monitor name, width, and height from each line
        name=$(echo "$line" | awk '{print $1}')
        primary=$(echo "$line" | awk '{print $2}')
        geometry=$(echo "$line" | awk '{print $3}')
        rotation=$(echo "$line" | awk '{print $5}')
    else
        name=$(echo "$line" | awk '{print $1}')
        primary=no_parimary
        geometry=$(echo "$line" | awk '{print $2}')
        rotation=$(echo "$line" | awk '{print $4}')
    fi

    # Display monitor information
    echo "Monitor: $name"
    echo "Geometry: $geometry"
    echo "Rotation: $rotation"
    echo "-------------------"

    # It works!!
    if [[ $name =~ VGA-1 ]]; then
        echo "Monitor: $name, Working!"
        xwinwrap -g $geometry -o 1.0 -ni -s -nf -b -un -fdt -argb -d -- mpv -wid WID --geometry=$geometry --no-audio  --no-osc --no-osd-bar --no-sub --quiet --loop ~/Videos/3327105-hd_1920_1080_24fps.mp4 --vid=1 --framedrop=vo --vo=gpu --hwdec=auto 
    fi

    if [[ $name =~ HDMI-1 ]]; then
        echo "Monitor: $name, Working!"
        xwinwrap -g $geometry -o 1.0 -ni -s -nf -b -un -fdt -argb -d -- mpv -wid WID --geometry=$geometry --no-audio  --no-osc --no-osd-bar --no-sub --quiet --loop ~/Videos/3371612-hd_1080_1920_30fps.mp4  --vid=1 --framedrop=vo --vo=gpu --hwdec=auto
    fi

done <<< "$monitor_info"
