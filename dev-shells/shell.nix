{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # install packages
  buildInputs = with pkgs; [
    python3
    lua
    # python libraries 
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pandas
      python-pkgs.requests
      python-pkgs.yq
    ]))
  ];

  # set config path for vim folders
  VIM_ROOT=/home/johnny/.config;

  shellHook =
  ''
    # install some neovim configs
    git clone https://github.com/AstroNvim/AstroNvim $VIM_ROOT/AstroNvim   # astro nvim
    git clone https://github.com/folke/lazy.nvim.git $VIM_ROOT/LazyNvim    # lazy nvim 
    git clone https://spacevim.org/git/repos/SpaceVim/ $VIM_ROOT/SpaceNvim # space nvim
    git clone git@github.com:NvChad/NvChad.git $VIM_ROOT/NvChad            # nvchad nvmim

    # nvims paths
    function nvims() {
      items=("default (nvim)" "nvim" "AstroNvim" "SpaceNvim" "NvChad")
      config=$(printf "%s\n" ''${items[@]} | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
      if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
      elif [[ $config == "default" ]]; then
        config=""
      fi
      NVIM_APPNAME=$config nvim $@
      exec zsh
    }
  '';
}
