{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  all-hies = import (builtins.fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
  ghcide-nix = import (builtins.fetchTarball "https://github.com/cachix/ghcide-nix/tarball/master") {};

  myLocation = "home";
  locations = {
    home = {
      lat = 30.2772;
      long = -97.7357;
    };
    work = {
      lat = 30.2770;
      long = -97.7432;
    };
  };

  latlong = location: if (lib.hasAttrByPath [ location ] locations) then locations.${location} else locations.home;
  background = "$HOME/.config/wallpaper/current";

in {

  nixpkgs.config.allowUnfree = true;

  # nixpkgs.config.packageOverrides = self : rec {
  #   blender = self.blender.override {
  #     cudaSupport = true;
  #   };
  # };

  home.packages = with pkgs; [
    unstable.cachix
    unstable.postman
    unstable.steam
    unstable.steam-run
    unstable.unityhub

    ghcide-nix.ghcide-ghc865

    bat                 # cat clone with syntax highlighting and git integration
    bmon                # network monitor
    dmenu               # minimal desktop menu
    dropbox
    fasd
    fd                  # find entries in filesystem
    fortune
    google-chrome
    htop
    jq
    kitty               # terminal
    lxmenu-data         # installed apps
    nix-zsh-completions
    mosh                # ssh alternative
    pavucontrol
    pcmanfm             # GUI file manager
    qalculate-gtk       # calculator
    ranger              # CLI file manager
    ripgrep
    shared_mime_info    # recognize file types
    tmux
    units
    yubioath-desktop
    zeal                # docs (like dash)

    # graphics / print
    blender
    flameshot           # screenshots (PrtSc)
    gimp
    scribusUnstable     # page layout
    scrot               # CLI screenshotter

    # programming - general
    aws-sam-cli         # AWS serverless app model
    exercism
    gnumake
    ltrace              # lib trace
    sourceHighlight
    strace              # system call trace
    tig                 # git tui frontend
    universal-ctags

    # programming - javascript
    nodejs
    yarn

    # programming - haskell
    ghc
    haskellPackages.apply-refact
    haskellPackages.ghcid
    haskellPackages.hindent
    haskellPackages.hlint
    unstable.haskellPackages.stylish-haskell

    # programming - python
    python3Packages.pynvim # for neovim

    # programming - ruby
    ruby
    rubyPackages_2_6.pry

    # chat / email
    # unstable.discord
    neomutt             # CLI mail
    protonmail-bridge
    signal-desktop
    slack
    thunderbird
    weechat
    unstable.zoom-us

    # fonts (format with !column -t)
    aileron            comfortaa              dejavu_fonts             dina-font
    eunomia            f5_6                   fantasque-sans-mono      ferrum
    fira               fira-code              fira-code-symbols        fira-mono
    font-awesome       helvetica-neue-lt-std  hermit                   ibm-plex
    inconsolata        iosevka                league-of-moveable-type  liberation_ttf
    libre-baskerville  libre-bodoni           libre-caslon             libre-franklin
    medio              mplus-outline-fonts    national-park-typeface   norwester-font
    penna              proggyfonts            route159                 seshat
    siji               tenderness             vegur                    vistafonts

    # formatters
    unstable.nixfmt
    unstable.ormolu
    unstable.uncrustify

    # media
    calibre             # e-book library
    evince              # another PDF viewer
    mplayer
    mpv
    ncmpcpp
    spotify
    vlc
  ];

  home.keyboard = {
    layout = "us";
    variant = "altgr-intl";
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
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
    home-manager.enable = true;

    direnv.enable       = true;
    emacs.enable        = true;
    firefox.enable      = true;
    fzf.enable          = true;
    keychain.enable     = true;
  };

  services = {
    picom = {
      enable       = true;
      fade         = true;
      fadeDelta    = 5;
      fadeSteps    = ["0.04" "0.04"];
      shadow       = true;
      backend      = "xrender";
      vSync        = true;
      # vSync        = "opengl";
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

    lorri.enable = true;

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
  xdg.userDirs.enable = true;

  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.feh}/bin/feh --bg-fill ${background}

      ${pkgs.networkmanagerapplet}/bin/nm-applet &

      ${pkgs.alsaUtils}/bin/amixer -c0 set Headphone 100%,100%

      ${pkgs.xidlehook}/bin/xidlehook \
        --not-when-fullscreen \
        --not-when-audio \
        --timer primary 600 '${pkgs.i3lock-pixeled}/bin/i3lock-pixeled' \
        --timer normal 3600 'systemctl suspend'
    '';

    windowManager.xmonad = rec {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        # haskellPackages.xmobar
      ];
    };

    pointerCursor = {
      package = pkgs.gnome3.gnome-themes-standard;
      size = 16; # default = 32; example = 64;
      defaultCursor = "left_ptr"; # example = "X_cursor";
      name = "Adwaita";
    };
  };

  home.file.".ghci".text = ''
    :seti -XGADTSyntax
    :seti -XGeneralizedNewtypeDeriving
    :seti -XInstanceSigs
    :seti -XLambdaCase
    :seti -XPartialTypeSignatures
    :seti -XScopedTypeVariables
    :seti -XTypeApplications
    :seti -XOverloadedStrings
    :set prompt "\ESC[1;34m%s\n\ESC[0;34mλ> \ESC[m"
    :set prompt-cont " \ESC[0;34m| \ESC[m"
    :set +t
  '';

  home.file.".railsrc".text = ''
    --skip-spring
  '';

  imports = [
    ./accounts
    ./environment.nix
    ./services/dunst
    ./services/polybar
    ./services/spotifyd
    ./programs/git
    ./programs/kitty
    ./programs/neomutt
    ./programs/neovim
    ./programs/rofi
    ./programs/tmux
    ./programs/vim
    ./programs/zathura
    ./programs/zsh
    ./xresources
  ];
}
