{
  enable = true;
  layout = "us(altgr-intl)";
  # xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # libinput.enable = true;

  videoDrivers = [ "nvidia" ];

  displayManager.sddm.enable = true;

  screenSection = ''
    Option "metamodes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
    Option "AllowIndirectGLXProtocol" "off"
    Option "TripleBuffer" "on"
  '';

  desktopManager = {
    xfce.enable = true;
    default = "xfce";
  };
}

