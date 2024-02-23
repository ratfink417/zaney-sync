{ pkgs, wallpaperDir, ... }:
pkgs.writeShellScriptBin "wallcmd" ''

TRANSITION1="--transition-type wave --transition-angle 120 --transition-step 30"
TRANSITION2="--transition-type wipe --transition-angle 30 --transition-step 30"
TRANSITION3="--transition-type center --transition-step 30"
TRANSITION4="--transition-type outer --transition-pos 0.3,0.8 --transition-step 30"
TRANSITION5="--transition-type wipe --transition-angle 270 --transition-step 30"
WALLPAPER=$(find ${wallpaperDir}/* -type f | shuf -n 1)
PREVIOUS=$WALLPAPER

NUM=$((1 + RANDOM % 5))
  case $NUM in
    1)
    TRANSITION=$TRANSITION1
    ;;
    2)
    TRANSITION=$TRANSITION2
    ;;
    3)
    TRANSITION=$TRANSITION3
    ;;
    4)
    TRANSITION=$TRANSITION4
    ;;
    5)
    TRANSITION=$TRANSITION5
    ;;
    esac
${pkgs.swww}/bin/swww img $WALLPAPER $TRANSITION
''
