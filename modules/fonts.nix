{ config, lib, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    league-gothic
    adwaita-fonts
    jetbrains-mono
    corefonts
    font-awesome
    source-han-sans
    powerline-fonts
    powerline-symbols
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}