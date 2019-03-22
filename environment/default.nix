{ pkgs, ... }:

{
  environment = {
    systemPackages = (import ./system-packages.nix) pkgs;
  };
}
