{ config, pkgs, lib, username, ... }:

{
  # install packages
  home.packages = with pkgs; [
    direnv
  ];

  # configure direnv
  programs.direnv= {
    enable = true;  
  };
}
