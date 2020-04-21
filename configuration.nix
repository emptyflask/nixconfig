# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # make a copy of this configuration, just in case
  environment.etc.current-nixos-config.source = ./.;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ./security
      ./services
      ./users
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot = {
    loader = {
      efi = {
        # canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        # efiInstallAsRemovable = true;
        # device = "/dev/nvme0n1";
        device = "nodev";
        useOSProber = true;
      };
      systemd-boot.enable = true;
    };

    # Kernel modules:
    # hide hdmi audio device
    # disable usb suspend so devices work after waking
    extraModprobeConfig = ''
      options snd_hda_intel enable=1,0
      options usbcore       autosuspend=-1
    '';
  };
  
  networking = {
    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
      allowPing = true;
    };
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs;
  let
      # Packages to always install.
      common = [
        ag
        bind
        binutils
        file
        fzf
        git
        gnupg
        gotop
        htop
        lsof
        neovim
        nmap
        mkpasswd
        p7zip
        pciutils
        ripgrep
        rsync
        tree
        unrar
        unzip
        w3m
        wget
        zip
      ];

      nox = [ vim ];

      x = [
        feh
        firefox
        rxvt_unicode_with-plugins
        xclip
        xidlehook
        xorg.xmessage
        xsel
        vimHugeX
      ];

  in common ++ (if config.services.xserver.enable then x else nox);

  # For USB mounting support (https://nixos.wiki/wiki/PCManFM)
  environment.variables.GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];

  fonts.fonts = with pkgs; [
    corefonts
    fira
    fira-code
    fira-code-symbols
    font-awesome
    ibm-plex
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ubuntu_font_family
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    libvirtd.enable = true;
    virtualbox = {
      host.enable = true;
      # enable extension pack to share usb ports, etc.
      # (requires building virtualbox)
      host.enableExtensionPack = false;
      host.addNetworkInterface = true;
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
