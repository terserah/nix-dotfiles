# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "catnux"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  ## plasma
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  ## Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = false;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };


  ## GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  ## Zram
  zramSwap.enable = true;

  ## Battery
  systemd.services.asus-battery-threshold = {
    description = "Set ASUS battery charge threshold";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
    };
  };

  systemd.services.asus-battery-threshold-resume = {
    description = "Reapply ASUS battery threshold after resume";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  security.sudo.wheelNeedsPassword = false;
  users.users.tabun = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["docker" "wheel" "audio" "video" "disk" "networkmanager"  ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };


  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
    vim
    wget
  ];

  ## Virtual
  virtualisation.docker = {
    enable = true;
  };

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

  system.stateVersion = "25.11"; # Did you read the comment?
  nix.settings.experimental-features = ["nix-command" "flakes"];

}

