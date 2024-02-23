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
    # import my scripts
    (import ../scripts/wallcmd.nix { inherit pkgs; inherit wallpaperDir; inherit username; inherit wallpaperGit; })
  ];

  # import my nix configurations
  imports = [
    # user configs
    ./zsh_settings.nix
    ./taskwarrior.nix
    ./vpn_menu.nix 
    ./theme_menu.nix 
  ];
}
