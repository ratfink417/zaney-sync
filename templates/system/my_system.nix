{ pkgs, config, inputs, ... }:
{
  # install my system packages
  environment.systemPackages = with pkgs; [
# vim
# git
  ];

  # import my system configs
  imports = [
# ./something_awesome.nix
  ];
}
