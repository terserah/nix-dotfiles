{ config, lib, pkgs, ... }:

{
  security.sudo.wheelNeedsPassword = false;
  users.users.tabun = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["docker" "wheel" "audio" "video" "disk" "networkmanager"  ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
}