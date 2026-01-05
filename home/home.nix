{ config, pkgs, burpsuitepro, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ./modules/git.nix
    ./modules/zsh.nix
  ];
  home.username = "tabun";
  home.homeDirectory = "/home/tabun";
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    burpsuitepro.packages.${pkgs.system}.default    
    android-studio
    heroic
    jetbrains.datagrip
    jetbrains.goland
    jetbrains.webstorm
    jetbrains.jdk
    mpv
    obsidian
    onlyoffice-desktopeditors
    obs-studio
    vscode
  ];




  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
