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
    ripgrep
    bottom
#    warp-terminal
    # import my scripts
    (import ../scripts/wallcmd.nix { inherit pkgs; inherit wallpaperDir; inherit username; inherit wallpaperGit; })
    (import ../scripts/app-launcher.nix { inherit pkgs; inherit username; })
    (import ../scripts/vpn-launcher.nix { inherit pkgs; inherit username; })
    (import ../scripts/zaney-sync.nix { inherit pkgs; inherit username; inherit flakeDir; })
  ];

  # import my nix configurations
  imports = [
    # user configs
    ./zsh_settings.nix
    ./taskwarrior.nix
    ./vpn-launch_menu.nix
    ./theme_menu.nix 
    ./app-launch_menu.nix
    ./lf.nix
    ./my_files.nix
  ];
}
