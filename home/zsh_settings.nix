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
      nano="NVIM_APPNAME='johnny-vim' nvim";
      vim="NVIM_APPNAME='johnny-vim' nvim";
      zaney-vim="NVIM_APPNAME='nvim' nvim";
      taskopen="taskopen -c /home/${username}/.config/task/taskopenrc";
      taskview="taskopen -c /home/${username}/.config/task/taskopenrc -x glow";
      c="clear";
    };

    # add zsh config picker (C-r)
    initExtra = ''
    eval "$(direnv hook zsh)"
    bindkey -s ^r "nvim-johnny\n"
    bindkey -s ^p "project-init\n"
    '';

   # source zshrc in zprofile cuz I guess that's where tmux can find it from
   profileExtra = ''
   if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.zshrc"
    fi
   fi
   '';
  };
}
