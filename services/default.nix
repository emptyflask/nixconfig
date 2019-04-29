{ pkgs, ... }:
{
  services = {
    # emacs.enable = true;
    # gnome3.gpaste.enable = true;

    acpid.enable = true;
    apcupsd.enable = true;
    clipmenu.enable = true;
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

    printing = {
      enable = true;
      # drivers = [];
    };

    samba.enable = true;
    pcscd.enable = true;
    redis.enable = true;

    udev.packages = [ pkgs.yubikey-personalization ];

    openvpn    = import ./openvpn;
    postgresql = import ./postgresql pkgs;
    xserver    = import ./xserver.nix;
  };
}
