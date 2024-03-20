{ config, pkgs, lib, username, ... }:
{
# packages needed for lazyvim
home.packages = with pkgs; [
    # lazyvim package denpendencies
    fd
    lazygit
    ripgrep
    # ruby
    ruby
    # julia
    julia
    # lua
    lua
    luarocks
    # java
    openjdk17
    # python
    #python3
#    poetry
#    (pkgs.python3.withPackages (python-pkgs: [
#      python-pkgs.pip
#    ]))
    # php
    php83
    php83Packages.composer
#    (pkgs.php.buildEnv{
#      extensions = ({ enabled, all }: enabled ++ (with all;[
#        xdebug
#      ]));
#    })
  ];
}
