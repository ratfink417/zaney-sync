{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # install packages for the user
  home.packages = with pkgs; [
    krita 
    openvpn 
    lazygit
  ];

  # import my nix configurations
  imports = [
    # user configs
    ./zsh_settings.nix
  ];
}
