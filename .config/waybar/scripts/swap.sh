#!/bin/bash

config_file="${HOME}/.config/waybar/config"
style_file="${HOME}/.config/waybar/style.css"

current_theme_file="${HOME}/.config/waybar/current"
current_theme=$(cat "$current_theme_file")

config_normal_file="${HOME}/.config/waybar/themes/theme_normal/config"
style_normal_file="${HOME}/.config/waybar/themes/theme_normal/style.css"
config_background_file="${HOME}/.config/waybar/themes/theme_background/config"
style_background_file="${HOME}/.config/waybar/themes/theme_background/style.css"

echo "$current_theme"
if [[ "$current_theme" == "normal" ]]  then
    cp $config_background_file $config_file
    echo "@import '$style_background_file';" > $style_file
    echo "background" > $current_theme_file
else
    cp $config_normal_file $config_file
    echo "@import '$style_normal_file';" > $style_file
    echo "normal" > $current_theme_file
fi

pkill -x waybar && waybar &
