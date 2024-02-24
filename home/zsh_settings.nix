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
    };
    # add zsh config picker
    initExtra = ''
function nvims() {
  items=("default (zaneyos nixvim)" "my-neovim" "NvChad" "AstroNvim")
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