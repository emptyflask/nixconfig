{ pkgs, ... }:
with pkgs;
{
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        user         = "emptyflask";
        password_cmd = "${pkgs.pass}/bin/pass spotify";
        device_name  = "nixos";
        bitrate      = "320";
        device_type  = "computer";
      };
    };
  };
}
