{ pkgs, ... }:
{
  services = {
    # emacs.enable = true;
    # gnome3.gpaste.enable = true;

    apcupsd.enable = true;
    openssh.enable = true;
    printing.enable = true;

    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];

    openvpn = import ./openvpn;
    xserver = import ./xserver.nix;
  };
}
