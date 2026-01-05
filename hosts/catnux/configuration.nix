# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/asusbat.nix
      ../../modules/bluetooth.nix
      ../../modules/fonts.nix
      ../../modules/gpu.nix
      ../../modules/package.nix
      ../../modules/pipewire.nix
      ../../modules/plasma.nix
      ../../modules/users.nix
      ../../modules/virtualisation.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "catnux"; 
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Jakarta";
  zramSwap.enable = true;
  system.stateVersion = "25.11";
  nix.settings.experimental-features = ["nix-command" "flakes"];

}

