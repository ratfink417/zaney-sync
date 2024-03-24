{ pkgs, ... }:
pkgs.writeShellScriptBin "initerm" ''
GRAVE_SESSIONS=$(tmux ls | grep -E -v '(attached)' | grep -Po '\d+\:.*')
TMP_SESSIONS=$(tmux ls | grep '(attached)' | grep -Po '^\d+\:.*')
NAMED_SESSIONS=$(tmux ls | grep -Po '^[^\d\:]+')
HOME_SESSION=$(tmux ls | grep -Po '^home\:.*')

# if there is no home session at all then create one
if [ -z "$HOME_SESSION" ]; then
	tmux new -s home
fi

# when there are detached temporary sessions kill them
if [ -n "$GRAVE_SESSIONS" ]; then
	echo "$GRAVE_SESSIONS" | grep -Po '^\d+' | xargs -n 1 tmux kill-session -t
fi

# if there is a home session that is un-attached then attach to it
if [ -n "$(echo $HOME_SESSION | grep -v '(attached)')" ]; then
	tmux attach -t home
fi

# if there is a home session thats attached, creat a new tmep session
if [ -n "$HOME_SESSION" ]; then
	tmux
fi
''
