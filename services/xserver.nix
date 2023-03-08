{
  enable = true;
  layout = "us";
  xkbVariant = "altgr-intl";
  xkbOptions = "compose:sclk";

  # Enable touchpad support.
  # libinput.enable = true;

  videoDrivers = [ "nvidia" ];

  displayManager = {
    defaultSession = "none+xmonad";
    lightdm.greeters.gtk = {
      enable = true;
      # user = "jon";
      # extraConfig = ''
      #   [greeter]
      #   show-password-label = false
      #   [greeter-theme]
      #   background-image = ""
      # '';
    };
  };

  windowManager.xmonad.enable = true;

  screenSection = ''
    Option "metamodes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
    Option "AllowIndirectGLXProtocol" "off"
    Option "TripleBuffer" "on"
  '';

}

