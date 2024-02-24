{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # install packages for the user
  home.packages = with pkgs; [
#    krita  # example
#    fzf    # example

    # import my scripts
    (import ../scripts/zaney-sync.nix { inherit pkgs; inherit wallpaperDir; inherit username; inherit flakeDir; })
  ];

  # import my nix configurations
  imports = [
    # user configs
    ./my_files.nix
#    ./taskwarrior.nix  # example
  ];
}
