{ pkgs, ... }:
{
  services = {
    acpid.enable    = true;
    apcupsd.enable  = true;
    clipmenu.enable = true;

    dbus.packages = with pkgs; [ gnome3.dconf ];

    elasticsearch = {
      enable = true;
      plugins = [ ];
    };

    emacs.enable                = false;
    gnome3.gnome-keyring.enable = true;
    gnome3.gpaste.enable        = false;
    locate.enable               = true;

    mpd = {
      enable = false;
      musicDirectory = "/media/repository/music";
    };

    ntp.enable = true;

    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
    };

    pcscd.enable    = true;
    printing.enable = true;
    redis.enable    = true;
    sabnzbd.enable  = true;
    samba.enable    = true;

    udev.packages = [ pkgs.yubikey-personalization ];

    nginx      = import ./nginx;
    openvpn    = import ./openvpn;
    postgresql = import ./postgresql pkgs;
    xserver    = import ./xserver.nix;
  };
}
