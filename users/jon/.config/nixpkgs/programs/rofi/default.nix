{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark";
    terminal = "${pkgs.kitty}/bin/kitty";
  };
}
