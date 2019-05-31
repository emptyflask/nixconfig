{ pkgs, ... }:
{
  services = {
    # emacs.enable = true;
    # gnome3.gpaste.enable = true;

    acpid.enable = true;
    apcupsd.enable = true;
    clipmenu.enable = true;
    elasticsearch = {
      enable = true;
      plugins = [
      ];
    };
    locate.enable = true;

    mpd = {
      enable = true;
      musicDirectory = "/media/repository/music";
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
    };

    pcscd.enable = true;
    printing.enable = true;
    redis.enable = true;
    sabnzbd.enable = true;
    samba.enable = true;

    udev.packages = [ pkgs.yubikey-personalization ];

    nginx      = import ./nginx;
    openvpn    = import ./openvpn;
    postgresql = import ./postgresql pkgs;
    xserver    = import ./xserver.nix;
  };
}
