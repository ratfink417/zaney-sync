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
      nvim-johnny="nix-shell /home/${username}/.dotfiles/config/dev-shells/shell.nix";
    };
    # add zsh config picker (C-r)
    initExtra = ''
    bindkey -s ^r "nvim-johnny\n"
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
