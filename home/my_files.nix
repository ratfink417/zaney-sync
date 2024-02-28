{ pkgs, config, ... }:

{
  # Place Files Inside Home Directory

  # my app launcher menu
  home.file.".config/rofi/app-launch.jpg".source = ./files/app-launch.jpg;
  # my vpn selection menu
  home.file.".config/rofi/vpn-launch.jpg".source = ./files/vpn-launch.jpg;
}
