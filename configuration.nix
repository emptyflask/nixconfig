# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  plexTcpPorts = [ 32400 3005 8324 32469 ];
  plexUdpPorts = [ 1900 5353 32410 32412 32413 32414 ];

in
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

  # fileSystems."/media/backup" =
  #   { device = "/dev/disk/by-uuid/82d748cc-d038-405c-9d5d-82d381a0999e";
  #   fsType = "ext4";
  #   options = ["defaults" "nofail" "user"];
  # };

  boot = {
    kernel = {
      sysctl = { "vm.swappiness" = "10"; };
    };
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
        configurationLimit = 32;
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
      allowedTCPPorts = [ 22 139 445 ] ++ plexTcpPorts;
      allowedUDPPorts = [ 137 138 ] ++ plexUdpPorts;
      allowPing = true;
      extraCommands = ''
        iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns
      '';
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
      min-free = ${toString  (100 * 1024 * 1024)} # 100MiB
      max-free = ${toString (1024 * 1024 * 1024)} # 1GiB
    '';

    settings = {
      auto-optimise-store = true;

      substituters = [
        "https://all-hies.cachix.org"
        "https://cache.iog.io"
        "https://cache.nixos.org/"
        "https://devenv.cachix.org"
        "https://digitallyinduced.cachix.org"
        "https://ghcide-nix.cachix.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
        "cache.iog.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE="
        "ghcide-nix.cachix.org-1:ibAY5FD+XWLzbLr8fxK6n8fL9zZe7jS+gYeyxyWYK5c="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "America/Chicago";

  environment.systemPackages =
    let
      # Packages to always install.
      common = with pkgs; [
        arion
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
        silver-searcher
        tree
        unrar
        unzip
        usbutils
        w3m
        wget
        zip
      ];

      # command-line-only
      nox = with pkgs; [ vim ];

      # with Xorg
      x = with pkgs; [
        feh
        firefox
        rxvt-unicode
        (steam.override {
          extraPkgs = pkgs: [ wavpack ];
        }).run
        xclip
        xorg.xkill
        xorg.xmessage
        xsel
        vimHugeX
        # vulkan-tools
        # vulkan-loader
        # vulkan-validation-layers
      ];

    in common ++ (if config.services.xserver.enable then x else nox);

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
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
    ];
    fontconfig = {
      defaultFonts = {
        serif     = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "Fira Mono" ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.dconf.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = { enable = true; polkitPolicyOwners = [ "jon" ]; };
  programs.adb.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.seahorse.enable = true;
  programs.ssh.startAgent = false;
  programs.steam.enable = true;
  programs.zsh.enable = true;

  hardware = {
    bluetooth.enable = true;

    # nvidia.prime.intelBusId = "PCI:1:0:1";
    # nvidia.modesetting.enable = true;

    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;

    opengl.enable = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    opengl.setLdLibraryPath = true;

    # video.hidpi.enable = false;
  };

  sound.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
    virtualbox = {
      host.enable = true;
      # enable extension pack to share usb ports, etc.
      # (requires building virtualbox)
      # host.enableExtensionPack = true;
      host.addNetworkInterface = true;
    };
    # oci-containers.containers.plex = {
    #   environment = {
    #     TZ = "America/Chicago";
    #     PUID = toString config.users.users.plex.uid;
    #     PGID = toString config.users.groups.media.gid;
    #     PLEX_CLAIM = "claim-yxovhjy9R4QmnHSVMvUZ";
    #     VERSION = "latest";
    #   };
    #   extraOptions = ["--network=host"];
    #   image = "linuxserver/plex";
    #   volumes = [
    #     "/media/repository/movies:/media"
    #     "/media/plex-config:/config"
    #   ];
    # };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "22.05"; # Did you read the comment?
  system.autoUpgrade.enable = false;
}
