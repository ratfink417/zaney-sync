{ config, pkgs, lib, username, ... }:

{
  # install packages
  home.packages = with pkgs; [
    taskwarrior
    taskwarrior-tui
    vit
    taskopen
    glow
  ];

  # configure taskwarrior
  programs.taskwarrior= {
    enable = true;
    dataLocation = "$HOME/.config/task/task_data";
    colorTheme = "dark-violets-256";
  };

# configure taskopen
  home.file."/home/${username}/.config/task/taskopenrc".text="
TASKBIN='task'
EDITOR='glow'
NOTES_FOLDER='$HOME/.config/task/tasknotes'
NOTES_EXT='.txt'
PATH_EXT=${pkgs.taskopen}/share/taskopen/scripts
  ";
}
