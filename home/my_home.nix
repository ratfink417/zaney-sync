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
    fzf
    # import my scripts
    (import ../scripts/wallcmd.nix { inherit pkgs; inherit wallpaperDir; inherit username; inherit wallpaperGit; })
    (import ../scripts/app-launcher.nix { inherit pkgs; inherit username; })
  ];

  # import my nix configurations
  imports = [
    # user configs
    ./zsh_settings.nix
    ./taskwarrior.nix
    ./vpn_menu.nix 
    ./theme_menu.nix 
    ./app-launch_menu.nix
    ./my_files.nix
  ];
}