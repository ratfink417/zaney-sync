# paths in my dotfiles tree
DOTFILES_ROOT=/home/johnny/.dotfiles
DOTFILES_HOME=$DOTFILES_ROOT/config/home
DOTFILES_FILES=$DOTFILES_HOME/config/files
DOTFILES_SYS=$DOTFILES_ROOT/config/system
DOTFILES_SCRIPTS=$DOTFILES_ROOT/config/scripts

# paths in the zaneyos dotfiles tree
ZANEYOS_ROOT=/home/johnny/src/zaneyos 
ZANEYOS_HOME=$ZANEYOS_ROOT/config/home
ZANEYOS_FILES=$ZANEYOS_HOME/config/files
ZANEYOS_SYS=$ZANEYOS_ROOT/config/system
ZANEYOS_SCRIPTS=$ZANEYOS_ROOT/config/scripts

# empty the dotfiles folder
rm -rf $DOTFILES_ROOT/*

# install zaneyos dotfiles 
cp -R $ZANEYOS_ROOT/* $DOTFILES_ROOT 

# install my dotfiles (hopefully in the right place in the new tree)
cp -rpv ./home/* $DOTFILES_HOME
cp -rpv ./system/* $DOTFILES_SYS
cp -rpv ./scripts/* $DOTFILES_SCRIPTS

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
cp ./options/options.nix $DOTFILES_ROOT/options.nix

# install the proper hardware.nix file
cp /etc/nixos/hardware-configuration.nix $DOTFILES_ROOT/hardware.nix
