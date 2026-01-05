{ config, lib, pkgs, ... }:
{
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
}