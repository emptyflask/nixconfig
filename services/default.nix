{ pkgs, ... }:

{
  services = {
    accounts-daemon.enable = true;
    acpid.enable           = true; # Advanced Configuration and Power Interface
    apcupsd.enable         = true; # UPS daemon

    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable       = true;
        addresses    = true;
        domain       = true;
        hinfo        = true;
        userServices = true;
        workstation  = true;
      };
    };

    blueman.enable         = true; # bluetooth manager
    chrony.enable          = true; # Time sync (replaces ntpd)
    clipmenu.enable        = true;

    dbus.packages = with pkgs; [ dconf ];

    devmon.enable = true;

    elasticsearch = {
      enable = false;
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
    gnome = {
      # evolution-data-server.enable = true;
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
    };
    gvfs.enable                 = true; # automount
    kbfs.enable                 = true; # $HOME/keybase
    keybase.enable              = true;

    kmscon = {
      enable = true;
      hwRender = true;
      extraConfig = ''
        font-name=Fira Code Regular
        font-size=12
        font-dpi=110
      '';
    };

    locate = {
      enable    = true;
      interval  = "hourly";
      localuser = null;
      locate    = pkgs.mlocate;
    };

    logind.extraConfig = ''
      HandlePowerKey=suspend
      IdleAction=suspend
      IdleActionSec=60m
      RuntimeDirectorySize=2G
    '';

    mpd = {
      enable = false;
      musicDirectory = "/media/repository/music";
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
    };

    pcscd.enable    = true; # Smartcard reader

#     plex = {
#       enable = true;
#       dataDir = "/media/repository/movies";
#       openFirewall = true;
#       package = nixUnstable.plex;
#     };

    printing.enable = true;
    redis.enable    = true;

    # Usenet downloader
    nzbget = {
      enable = true;
      settings = {
      };
    };
    sabnzbd.enable = false;

    # Windows file sharing
    samba = {
      enable = true;
      securityType = "user";
      extraConfig = ''
        workgroup      = WORKGROUP
        server string  = nixos
        netbios name   = nixos
        security       = user
        hosts allow    = 10., 192.168., localhost
        hosts deny     = 0.0.0.0/0
        guest account  = nobody
        map to guest   = bad user
        # use sendfile   = yes
        # max protocol   = smb2
      '';
      shares = {
        public = {
          "path"           = "/home/jon/public";
          "browseable"     = "yes";
          "read only"      = "no";
          "guest ok"       = "yes";
          "create mask"    = "0644";
          "directory mask" = "0755";
          "force user"     = "jon";
          "force group"    = "users";
        };
        incoming = {
          "path"           = "/home/jon/public/incoming";
          "browseable"     = "no";
          "read only"      = "no";
          "guest ok"       = "yes";
          "create mask"    = "0644";
          "directory mask" = "0755";
          "force user"     = "jon";
          "force group"    = "users";
        };
      };
    };

    tumbler.enable = true; # thumbnail generator

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
    upower.enable = true;

    borgbackup = import ./borgbackup.nix;
    nginx      = import ./nginx;
    openvpn    = import ./openvpn;
    postgresql = import ./postgresql pkgs;
    xserver    = import ./xserver.nix;
  };

  imports = [ ./hoogle ];
}
