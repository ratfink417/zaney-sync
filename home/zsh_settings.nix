{ config, lib, pkgs, username, ... }:

let inherit (import ../../options.nix) flakeDir theShell; in
lib.mkIf (theShell == "zsh") {
  programs.zsh = {
    # setup sessionVariables for zsh
    sessionVariables = {
	EDITOR="nvim";
      };
    # setup shell aliases for zsh
    shellAliases = {
      nano="nvim";
      vim="nvim";
      taskopen="taskopen -c /home/${username}/.config/task/taskopenrc";
      taskview="taskopen -c /home/${username}/.config/task/taskopenrc -x glow";

      # because I can't type the word "clear" without fat fingering it
      c="clear";

      # nvims paths
      nvim-zaney="NVIM_APPNAME=nvim nvim";
      nvim-astro="NVIM_APPNAME=AstroNvim nvim";
    };
    # add zsh config picker
    initExtra = ''
export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
function nvims() {
  items=("default (nvim)" "nvim" "AstroNvim" "LazyNvim"  "SpaceNvim" "NvChad")
  config=$(printf "%s\n" ''${items[@]} | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"
    '';
  };
}
