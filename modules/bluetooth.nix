{ config, lib, pkgs, ... }:
{
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
}