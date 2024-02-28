{ pkgs, username }:

pkgs.writeShellScriptBin "vpn-launcher" ''
  if pgrep -x "rofi" > /dev/null; then
    # Rofi is running, kill it
    pkill -x rofi
    exit 0
  fi
  rofi -show drun -config /home/${username}/.config/rofi/vpn-launch.rasi
''
