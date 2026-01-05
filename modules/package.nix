{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
    vim
    wget
  ];
  # flatpak
  services.flatpak.enable = true;
}