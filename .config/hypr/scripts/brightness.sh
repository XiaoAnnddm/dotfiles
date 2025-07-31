#!/bin/bash

# 亮度控制脚本
get_brightness() {
    brightnessctl get
}

get_max_brightness() {
    brightnessctl max
}

get_brightness_percent() {
    current=$(get_brightness)
    max=$(get_max_brightness)
    echo $((current * 100 / max))
}

send_notification() {
    brightness=$(get_brightness_percent)
    
    if [[ $brightness -eq 0 ]]; then
        icon="🌑"
    elif [[ $brightness -lt 25 ]]; then
        icon="🌘"
    elif [[ $brightness -lt 50 ]]; then
        icon="🌗"
    elif [[ $brightness -lt 75 ]]; then
        icon="🌖"
    else
        icon="🌕"
    fi
    
    notify-send -a "brightness" -u low -h string:x-canonical-private-synchronous:brightness \
                -h int:value:$brightness "$icon" "亮度: ${brightness}%"
}

case $1 in
    up)
        brightnessctl set +5%
        send_notification
        ;;
    down)
        brightnessctl set 5%-
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down}"
        ;;
esac
