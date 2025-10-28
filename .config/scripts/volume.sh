#!/bin/bash

# 音量控制脚本
get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'
}

get_mute_status() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED" && echo "muted" || echo "unmuted"
}

send_notification() {
    volume=$(get_volume)
    mute_status=$(get_mute_status)
    
    if [[ "$mute_status" == "muted" ]]; then
        icon="🔇"
        text="音量: 静音"
        progress=0
    else
        if [[ $volume -eq 0 ]]; then
            icon="🔇"
        elif [[ $volume -lt 30 ]]; then
            icon="🔈"
        elif [[ $volume -lt 70 ]]; then
            icon="🔉"
        else
            icon="🔊"
        fi
        text="音量: ${volume}%"
        progress=$volume
    fi
    
    notify-send -a "volume" -u low -h string:x-canonical-private-synchronous:volume \
                -h int:value:$progress "$icon" "$text"
}

case $1 in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        send_notification
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        ;;
esac
