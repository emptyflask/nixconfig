{
  enable = true;
  layout = "us(altgr-intl)";
  # xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # libinput.enable = true;

  videoDrivers = [ "nvidia" ];

  displayManager.sddm.enable = true;

  desktopManager = {
    xfce.enable = true;
    default = "xfce";
  };
}

