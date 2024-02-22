{ pkgs, config, inputs, ... }:
{
  # install my system packages
  environment.systemPackages = with pkgs; [
  ];

  # import my system configs
  imports = [
  ];
}
