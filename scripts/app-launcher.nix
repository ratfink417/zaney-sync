{ pkgs, username }:

pkgs.writeShellScriptBin "app-launcher" ''
  if pgrep -x "rofi" > /dev/null; then
    # Rofi is running, kill it
    pkill -x rofi
    exit 0
  fi
  rofi -show drun -config /home/${username}/.config/rofi/app-launch.rasi
''
