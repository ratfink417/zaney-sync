{ pkgs, wallpaperDir, }:
pkgs.writeShellScriptBin "wallock" ''

swayidle -w timeout 720 'swaylock -f' timeout 800 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f -i $(find ${wallpaperDir}/* -type f | shuf -n 1)'

''
