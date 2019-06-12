{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable>       { config = { allowUnfree = true; }; };
  small    = import <nixos-unstable-small> { config = { allowUnfree = true; }; };

  # cart = import "/home/jon/dev/sxsw/cart/default.nix";

  myLocation = "home";
  locations = {
    home = {
      lat = 30.2772;
      long = -97.7357;
    };
  };

  latlong = location: if (lib.hasAttrByPath [ location ] locations) then locations.${location} else locations.home;
  background = "$HOME/.config/wallpaper/current";

in {

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = self : rec {
    blender = self.blender.override {
      cudaSupport = true;
    };
  };

  home.packages = with pkgs; [
    unstable.signal-desktop
    unstable.slack
    small.steam
    small.steam-run

    haskellPackages.greenclip  # a different clipboard manager

    albert     # ctrl-space
    antibody
    blender
    calibre    # e-book library
    dmenu
    dropbox
    evince     # PDF viewer
    exercism
    fasd
    fd
    fortune
    gimp
    htop
    i3lock-fancy
    irssi
    kitty    # terminal
    mplayer
    mpv
    ncmpcpp
    neomutt  # CLI mail
    nix-zsh-completions
    pavucontrol
    pcmanfm  # GUI file manager
    ranger   # CLI file manager
    ripgrep
    ruby
    scrot    # CLI screenshotter
    spotify
    stalonetray
    thunderbird
    tig
    units
    vlc
    zathura # minimal PDF viewer
    zeal
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    direnv.enable = true;

    emacs = {
      enable = true;
      extraPackages = epkgs: with epkgs; [
        evil
        evil-cleverparens
        evil-indent-textobject
        evil-surround
        magit
        nix-mode
        undo-tree
      ];
    };

    firefox = {
      enable = true;
      enableIcedTea = true;
    };

    rofi = {
      enable = true;
      theme = "sidebar";
    };

    vim = {
      plugins     = pkgs.appConfigs.vim.knownPlugins;
      extraConfig = pkgs.appConfigs.vim.vimConfig;
    };
  };

  services = {
    compton = {
      enable    = true;
      fade      = true;
      fadeDelta = 5;
      fadeSteps = ["0.04" "0.04"];
      shadow    = true;
      backend   = "glx";
      vSync     = "opengl-swc";
      extraOptions = ''
        clear-shadow = true;
        glx-no-rebind-pixmap = true;
        glx-no-stencil = true;
        paint-on-overlay = true;
        xrender-sync-fence = true;
      # blur-background = true;
      # blur-background-fixed = true;
      # blur-kern = "9,9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,";
      '';
    };

    gpg-agent = {
      enable           = true;
      defaultCacheTtl  = (60 * 60 * 4);
      enableSshSupport = true;
    };

    redshift = {
      enable    = true;
      latitude  = toString (latlong myLocation).lat;
      longitude = toString (latlong myLocation).long;
      tray      = true;
    };
  };

  xdg.enable = true;

  # xscreensaver.enable = true;

  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.feh}/bin/feh --bg-fill ${background}

      # ${pkgs.xautolock}/bin/xautolock -time 10 -locker ${pkgs.i3lock-fancy}/bin/i3lock-fancy -nowlocker ${pkgs.i3lock-fancy}/bin/i3lock-fancy &
      # xautolock -time 5 -locker i3lock-fancy -notify 20 -notifier 'xset dpms force off' & 
      # xautolock -time 7 -locker "systemctl suspend" &    

      ${pkgs.xidlehook}/bin/xidlehook \
      --not-when-fullscreen \
      --not-when-audio \
      --timer primary 600 '${pkgs.i3lock-fancy}/bin/i3lock-fancy' \
      --timer normal 3600 'systemctl suspend'
    '';
    windowManager.xmonad = rec {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmobar
        haskellPackages.xmonad
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
      ];
    };
  };

#  systemd.user.services.sxsw-cart = {
#    Unit = {
#      Description = "SXSW Cart";
#    };
#    Service = {
#      WorkingDirectory = "/home/jon/dev/sxsw/cart";
#      # ExecStart = "nix-shell --run 'bundle exec foreman start -p 5001'";
#      ExecStart = "${(import ./default.nix).wrapper}";
#      ExecStart = pkgs.writeScript "wrapper" ''
#              #! ${pkgs.stdenv.shell} -el
#              exec ${usercfg.home.activationPackage}/activate
#      '';
#    };
#  };

  imports = [
    ./services/polybar
    ./programs/neovim
    ./programs/zsh
  ];
}
