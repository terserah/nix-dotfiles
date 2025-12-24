{ pkgs, ... }:
{

  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.battery-health-charging
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
  ];
  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-uri = "file:///data/Pictures/minimalism-cat-animals-colorful-wallpaper-fb364cfd23912f6935d44b396dcc6c50.jpg";
      picture-uri-dark = "file:///data/Pictures/minimalism-cat-animals-colorful-wallpaper-fb364cfd23912f6935d44b396dcc6c50.jpg";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/mutter" = {
      experimental-features = [
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        caffeine.extensionUuid
        battery-health-charging.extensionUuid
        clipboard-indicator.extensionUuid
        dash-to-dock.extensionUuid
      ];
    };
  };
}
