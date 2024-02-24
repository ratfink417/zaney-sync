{ pkgs, config, ... }:

{
  # Place Files Inside Home Directory
  home.file.".config/rofi/app-launch.jpg".source = ./files/app-launch.jpg;
}
