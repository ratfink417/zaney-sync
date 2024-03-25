{ config, pkgs, lib, username, ... }:
let
  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux-super-fingers";
      version = "unstable-2023-01-06";
      src = pkgs.fetchFromGitHub {
        owner = "artemave";
        repo = "tmux_super_fingers";
        rev = "2c12044984124e74e21a5a87d00f844083e4bdf7";
        sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
      };
    };
in
{
  # install packages
  home.packages = with pkgs; [
    tmux
  ];
  # configure tmux
  programs.fzf.tmux.enableShellIntegration = true;
  programs.tmux= {
    enable = true;

  # option settings
    sensibleOnTop = false; # don't install the sensible-tmux plugin
    mouse = true;
    newSession = true; # Automatically spawn a session if trying to attach and none are running. (this should make it okay to ditch initerm)
    prefix = "C-a";

    # install tmux plugins
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      tmux-fzf
      {
          plugin = tmux-super-fingers;
          extraConfig = "set -g @super-fingers-key f";
        }
    ];
  extraConfig = ''
    # Smart pane switching with awareness of Vim splits.
    # See: https://github.com/christoomey/vim-tmux-navigator
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
    bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
    bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
    bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
    bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
    tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
    if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
    if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

    # movement keys 
    bind-key -T copy-mode-vi 'C-h' select-pane -L
    bind-key -T copy-mode-vi 'C-j' select-pane -D
    bind-key -T copy-mode-vi 'C-k' select-pane -U
    bind-key -T copy-mode-vi 'C-l' select-pane -R
    bind-key -T copy-mode-vi 'C-\' select-pane -l

    # status bar config
    set-option -g status-position top    # position the status bar at top of screen

    # show host name and IP address on left side of status bar
    set -g status-left-length 85
    set -g status-left "#[fg=colour198] #h : #[fg=brightblue]#(curl icanhazip.com) #(ifconfig en0 | grep 'inet ' | awk '{print \"en0 \" $2}') #(ifconfig en1 | grep 'inet ' | awk '{print \"en1 \" $2}') #(ifconfig en3 | grep 'inet ' | awk '{print \"en3 \" $2}') #(ifconfig tun0 | grep 'inet ' | awk '{print \"vpn \" $2}') "

    # show session name, window & pane number, date and time on right side of
    set -g status-right-length 60
    set -g status-right "#[fg=blue]#S #I:#P #[fg=yellow]: %d %b %Y #[fg=green]: %l:%M %p : #(date -u | awk '{print $4}') :"
    set -g status-right "#[fg=blue]#(tmux-cpu --no-color)"

    # pane splitting
    bind \\ split-window -h
    bind - split-window -v

    # resizing panes
    bind-key -r j resize-pane -D 5
    bind-key -r k resize-pane -U 5
    bind-key -r h resize-pane -L 5
    bind-key -r l resize-pane -R 5
  '';
  };
}
