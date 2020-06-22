{ pkgs, ... }:

{
  services = {
    accounts-daemon.enable = true;
    acpid.enable           = true;
    apcupsd.enable         = true;
    clipmenu.enable        = true;

    dbus.packages = with pkgs; [ gnome3.dconf ];

    devmon.enable = true;

    elasticsearch = {
      enable = true;
      cluster_name = "schrödinger";
      plugins = with pkgs.elasticsearchPlugins; [
        # analysis-icu
        # analysis-lemmagen
        # analysis-phonetic
      ];
      extraConf = "";
      extraJavaOptions = [ "-Xms500m" "-Xmx1g" ];
    };

    emacs.enable                = false;
    gnome3.gnome-keyring.enable = true;
    kbfs.enable                 = true; # $HOME/keybase
    keybase.enable              = true;

    kmscon = {
      enable = true;
      hwRender = true;
      extraConfig = ''
        font-name=Fira Code Regular
        font-size=12
        font-dpi=96
      '';
    };

    locate = {
      enable    = true;
      interval  = "hourly";
      localuser = null;
      locate    = pkgs.mlocate;
    };

    logind.extraConfig = ''
      RuntimeDirectorySize=2G
    '';

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

    udev = {
      packages = [
        pkgs.libu2f-host
        pkgs.yubikey-personalization
      ];
      extraRules = ''
        # Generic stm32 (for flashing Preonic keyboard)
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666"
      '';
    };

    udisks2.enable = true;

    nginx      = import ./nginx;
    openvpn    = import ./openvpn;
    postgresql = import ./postgresql pkgs;
    xserver    = import ./xserver.nix;
  };
}
