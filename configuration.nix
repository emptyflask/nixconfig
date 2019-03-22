# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ./environment
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
    # hide hdmi audio device
    extraModprobeConfig = ''
      options snd_hda_intel enable=1,0
    '';
  };
  
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;


  hardware.opengl.driSupport32Bit = true;


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
