{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # install packages
  buildInputs = with pkgs; [
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
    python3
    poetry
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pip
    ]))

    # php 
    php83
    php83Packages.composer
    (pkgs.php.buildEnv{
      extensions = ({ enabled, all }: enabled ++ (with all;[
        xdebug
      ]));
    })
  ];

  NVIM_APPNAME="johnny-vim";
  VIM_ROOT="/home/johnny/.config";
  CONFIG_REPO="git@github.com:ratfink417/johnny-vim.git";
  shellHook =
  ''
    # install my neovim config if it's not already on the system
    if [ ! "$(cd $VIM_ROOT/$NVIM_APPNAME && git config --get remote.origin.url)" == "$CONFIG_REPO" ]; then
      git clone $CONFIG_REPO $VIM_ROOT/$NVIM_APPNAME
    fi

    # go into my default shell zsh
    exec zsh
  '';
}
