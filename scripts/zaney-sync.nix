{ pkgs, username, flakeDir, ... }:
pkgs.writeShellScriptBin "zaney-sync" ''
# path where your source files are kept (parent folder of zaney-sync)
USER_SRC_FOLDER=/home/${username}/src

# path where zaney-sync sources should be kept
ZANEY_SYNC_ROOT=$USER_SRC_FOLDER/zaney-sync

# paths in my dotfiles tree
DOTFILES_ROOT=${flakeDir}
DOTFILES_HOME=$DOTFILES_ROOT/config/home
DOTFILES_FILES=$DOTFILES_HOME/config/files
DOTFILES_SYS=$DOTFILES_ROOT/config/system
DOTFILES_SCRIPTS=$DOTFILES_ROOT/config/scripts

# my neovim repo
MY_NEOVIM_REPO="git@github.com:ratfink417/johnny-vim.git"
MY_NEOVIM_CONFIG_DIR=/home/${username}/.config/johnny-vim
MY_NEOVIM_REPO_NAME=johnny-vim

# paths in the zaneyos dotfiles tree
ZANEYOS_ROOT=/home/${username}/src/zaneyos 
ZANEYOS_HOME=$ZANEYOS_ROOT/config/home
ZANEYOS_FILES=$ZANEYOS_HOME/config/files
ZANEYOS_SYS=$ZANEYOS_ROOT/config/system
ZANEYOS_SCRIPTS=$ZANEYOS_ROOT/config/scripts

# ensure the zaney-sync repo exists in /home/user_name/src/
cd $USER_SRC_FOLDER
cd $ZANEY_SYNC_ROOT
echo "Ensuring /home/${username}/src/zaney-sync exists..."
GIT_REPO_NAME=$(git config --get remote.origin.url)
if ! [ "$GIT_REPO_NAME" = "git@github.com:ratfink417/zaney-sync.git" ]; then
  git clone git@github.com:ratfink417/zaney-sync.git
fi
cd $ZANEY_SYNC_ROOT

# empty the dotfiles folder
rm -rf $DOTFILES_ROOT/*

# install zaneyos dotfiles 
cp -R $ZANEYOS_ROOT/* $DOTFILES_ROOT 

# install my dotfiles (hopefully in the right place in the new tree)
cp -rpv ./system/* $DOTFILES_SYS
cp -rpv ./scripts/* $DOTFILES_SCRIPTS
cp -rpv ./dev-shells $DOTFILES_ROOT/config
cp -rpv ./home/* $DOTFILES_HOME
cp -rpv ./home/files/* $DOTFILES_FILES

# add my_home.nix to config/home/default.nix with sed or diff
NIX_HOME_FILE_ADDED=$(cat $DOTFILES_HOME/default.nix)
if ! echo $NIX_HOME_FILE_ADDED | grep -q "my.nix"; then
  sed -i 's/\]\;/  \.\/my_home\.nix\n  \]\;/' $DOTFILES_HOME/default.nix
fi

# add my_system.nix to config/system/default.nix with sed or diff
NIX_SYS_FILE_ADDED=$(cat $DOTFILES_SYS/default.nix)
if ! echo $NIX_SYS_FILE_ADDED | grep -q "my.nix"; then
  sed -i 's/\]\;/  \.\/my_system\.nix\n  \]\;/' $DOTFILES_SYS/default.nix
fi

# install the proper optoins.nix file 
if [ "$OPTION_CHOICE" = "desktop" ]; then
  echo "Applying your desktop options"
  cp ./options/desktop.nix $DOTFILES_ROOT/options.nix
fi

if [ "$OPTION_CHOICE" = "laptop" ]; then
  echo "Applying your desktop options"
  cp ./options/laptop.nix $DOTFILES_ROOT/options.nix
fi

# install the proper hardware.nix file
cp /etc/nixos/hardware-configuration.nix $DOTFILES_ROOT/hardware.nix

# prompt: ask user which config to choose
while [ true ]
do
  clear
  echo "which options file needs to be installed?"
  echo
  ls -l options | grep -Po "[^\s]+\.nix"
  echo
  echo "file name: "
  read OPTION_CHOICE

  # make sure the answered file name wasn't mispelled
  if test -f ./options/$OPTION_CHOICE; then
    cp -v ./options/$OPTION_CHOICE $DOTFILES_ROOT/options.nix
    break
  else
    echo "you may have mispelled your answer"
  fi
done
# END prompt

# ensure my lazyvim config is installed
cd $MY_NEOVIM_CONFIG_DIR
echo "Ensuring /home/${username}/.config/nvim holds my config..."
MY_NEOVIM_REPO_ASSERTION=$(git config --get remote.origin.url)
if ! [ "$MY_NEOVIM_REPO_ASSERTION" = "$MY_NEOVIM_REPO" ]; then
  cd ..
  rm -rf $MY_NEOVIM_CONFIG_DIR/*
  git clone $MY_NEOVIM_REPO $MY_NEOVIM_CONFIG_DIR
fi
''
