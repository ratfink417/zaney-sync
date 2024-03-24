{ pkgs, config, inputs, ... }:
{
  # install my system packages
  environment.systemPackages = with pkgs; [
  ];

  # import my system configs
  imports = [
    ./wireshark.nix
  ];
  # allow FHS based programs to link their programs so they work in nix
  # I needed this for lazyvim mason to work. I don't care if it's not the nix way, I need LSP and I need it to be easy to do
  programs.nix-ld.enable = true;
}
