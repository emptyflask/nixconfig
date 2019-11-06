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
    unstable.blender
    unstable.postman
    unstable.scribusUnstable
    unstable.signal-desktop
    unstable.slack
    small.steam
    small.steam-run

    albert              # ctrl-space
    antibody
    calibre             # e-book library
    dmenu
    dropbox
    evince              # PDF viewer
    exercism
    fasd
    fd
    flameshot           # screenshots (PrtSc)
    fortune
    gimp
    ghc
    haskellPackages.ghcid
    # haskellPackages.greenclip  # a different clipboard manager
    haskellPackages.hindent
    haskellPackages.hlint
    # haskellPackages.intero
    htop
    i3lock-fancy
    jq
    kitty               # terminal
    lxmenu-data         # installed apps
    mplayer
    mpv
    ncmpcpp
    neomutt             # CLI mail
    nix-zsh-completions
    nodejs
    pavucontrol
    pcmanfm             # GUI file manager
    ranger              # CLI file manager
    ripgrep
    ruby
    scrot               # CLI screenshotter
    shared_mime_info    # recognize file types
    spotify
    stalonetray
    thunderbird
    tig
    tmux
    units
    vlc
    weechat
    yarn
    zathura             # minimal PDF viewer
    zeal                # docs

    # fonts
    aileron
    eunomia
    f5_6
    ferrum
    helvetica-neue-lt-std
    league-of-moveable-type
    libre-baskerville
    libre-bodoni
    libre-caslon
    libre-franklin
    national-park-typeface
    norwester-font
    medio
    penna
    route159
    seshat
    tenderness
    vegur
    vistafonts
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome3.gnome_themes_standard;
      name = "Adwaita";
    };
    font = {
      name = "Noto Sans 10";
      package = pkgs.noto-fonts;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome3.gnome-themes-standard;
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    direnv.enable = true;

#     emacs = {
#       enable = true;
#       extraPackages = epkgs: with epkgs; [
#         evil
#         evil-cleverparens
#         evil-indent-textobject
#         evil-surround
#         magit
#         nix-mode
#         undo-tree
#       ];
#     };

    firefox = {
      enable = true;
      enableIcedTea = true;
    };

    rofi = {
      enable = true;
      theme = "gruvbox-dark";
    };
  };

  services = {
    compton = {
      enable       = true;
      fade         = true;
      fadeDelta    = 5;
      fadeSteps    = ["0.04" "0.04"];
      shadow       = true;
      backend      = "xrender";
      vSync        = "opengl";
      extraOptions = ''
        clear-shadow          = true;
        glx-no-rebind-pixmap  = true;
        glx-no-stencil        = true;
        # glx-copy-from-front   = false;
        glx-swap-method       = "copy";
        paint-on-overlay      = true;
        xrender-sync-fence    = true;
      '';
    };

    gpg-agent = {
      enable           = true;
      defaultCacheTtl  = (60 * 60 * 4);
      enableSshSupport = true;
    };

    mpd.enable = true;

    redshift = {
      enable    = true;
      latitude  = toString (latlong myLocation).lat;
      longitude = toString (latlong myLocation).long;
      tray      = true;
    };

    xscreensaver = {
      enable = true;
      settings = {
        lock = true;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk"; # gnome or gtk
  };

  xdg.enable = true;

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
    pointerCursor = {
      package = pkgs.gnome3.gnome-themes-standard;
      size = 16; # default = 32; example = 64;
      defaultCursor = "left_ptr"; # example = "X_cursor";
      name = "Adwaita";
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
    ./services/dunst
    ./services/polybar
    ./programs/git
    ./programs/neovim
    ./programs/tmux
    ./programs/vim
    ./programs/zsh
    ./xresources
  ];
}
