{ config, pkgs, lib, username, ... }:

{
  # install packages
  environment.systemPackages = with pkgs; [
    wireshark
    tshark
    termshark
  ];

  # configure wireshark
  programs.wireshark= {
    enable = true;
  };
}
