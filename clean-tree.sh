# prompt for a configuration file path
echo "Where are you going to keep your dotfiles/configurations ?"
read DOTFILES_ROOT
echo "using: $DOTFILES_ROOT"

# do some normalization so that the var can be used in another sed command
DOTFILES_ROOT=$(echo $DOTFILES_ROOT | sed 's/\//\\\//g')

# replace my variables for bootstrap.sh with yours 
sed -i "s/\/home\/johnny\/\.dotfiles/$DOTFILES_ROOT/" ./bootstrap.sh

# delete ratfink417's configurations
rm -rf ./home 
rm -rf ./system 
rm -rf ./scripts 
rm -rf ./options/*

# install templates
cp -R ./templates/home .
cp -R ./templates/system .
cp -R ./templates/scripts .

# Display message
echo "The config tree has been cleaned. Now you can add your own files and follow the guidance from the README.md to keep your own configurations here"
echo "configuration file being used is:"
grep -Po "DOTFILES_ROOT=[^\s]+" bootstrap.sh
echo
echo "If this is what you intended then you should run the ./bootstrap.sh script and place your options.nix files the ./options folder"
