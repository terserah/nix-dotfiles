{ config, pkgs, ... }:
{
 programs.git = {
    enable = true;
    settings.user.email = "yurandarezky@atmaluhura.ac.id";
    settings.user.name = "terserah";
  };
}
