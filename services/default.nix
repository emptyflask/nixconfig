{ pkgs, ... }:

{
  services = {
    accounts-daemon.enable = true;
    acpid.enable           = true; # Advanced Configuration and Power Interface
    apcupsd.enable         = true; # UPS daemon
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
    gvfs.enable                 = true; # automount
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

    ntp.enable = true; # Time sync

    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
    };

    pcscd.enable    = true; # Smartcard reader
    printing.enable = true;
    redis.enable    = true;
    sabnzbd.enable  = true; # Usenet downloader
    samba.enable    = true; # Windows file sharing

    udev = {
      packages = [
        pkgs.libu2f-host
        pkgs.yubikey-personalization
      ];
      extraRules = ''
        SUBSYSTEM=="block", ENV{UDISKS_FILESYSTEM_SHARED}="1"

        # Generic stm32 (for flashing Preonic keyboard)
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666"

        # Teensy 2.0 / atmega32u4 (LFKpad)
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="feed", ATTRS{idProduct}=="6060", MODE:="0666"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="0478", MODE:="0666"
      '';
    };

    # udisks2.enable = true;

    borgbackup = import ./borgbackup.nix;
    nginx      = import ./nginx;
    openvpn    = import ./openvpn;
    postgresql = import ./postgresql pkgs;
    xserver    = import ./xserver.nix;
  };
}
