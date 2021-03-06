# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # make a copy of this configuration, just in case
  environment.etc.current-nixos-config.source = ./.;

  imports =
    [ ./hardware-configuration.nix
      ./security
      ./services
      ./users
    ];

  nixpkgs.config.allowUnfree = true;

  fileSystems."/media/repository" = {
    device = "/dev/disk/by-uuid/8CFA8C6CFA8C547C";
    fsType = "ntfs";
    options = ["defaults" "user"];
  };

  fileSystems."/media/backup" =
    { device = "/dev/disk/by-uuid/82d748cc-d038-405c-9d5d-82d381a0999e";
    fsType = "ext4";
    options = ["defaults" "nofail" "user"];
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      # grub = {
      #   enable = true;
      #   device = "nodev";
      #   efiSupport = true;
      #   useOSProber = true;
      #   version = 2;
      # };
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        memtest86.enable = true;
      };
    };

    # Kernel modules:
    # don't load module for secondary ethernet adapter
    blacklistedKernelModules = ["alx"];
    # disable usb suspend so devices work after waking
    extraModprobeConfig = ''
      options usbcore       autosuspend=-1
    '';
  };
  
  networking = {
    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      enableStrongSwan = true;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 139 445 ];
      allowedUDPPorts = [ 137 138 ];
      allowPing = true;
      extraCommands = ''
        iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns
      '';
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n.defaultLocale = "en_US.UTF-8";

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
        hwinfo
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
        usbutils
        w3m
        wget
        zip
      ];

      nox = [ vim ];

      x = [
        feh
        firefox
        rxvt_unicode-with-plugins
        xclip
        xorg.xkill
        xorg.xmessage
        xsel
        vimHugeX
      ];

  in common ++ (if config.services.xserver.enable then x else nox);

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      fira
      fira-code
      fira-code-symbols
      fira-mono
      helvetica-neue-lt-std
      ibm-plex
      inconsolata
      liberation_ttf
      libre-baskerville
      libre-bodoni
      libre-caslon
      libre-franklin
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ubuntu_font_family
      vistafonts
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif     = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "Fira Mono" ];
      };
    };
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # programs.dconf.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.seahorse.enable = true;

  hardware = {
    bluetooth.enable = true;

    # nvidia.prime.intelBusId = "PCI:1:0:1";
    # nvidia.modesetting.enable = true;

    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;

    opengl.enable = true;
    opengl.driSupport32Bit = true;
  };

  sound.enable = true;

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
      # host.enableExtensionPack = true;
      host.addNetworkInterface = true;
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
  system.autoUpgrade.enable = true;
}
