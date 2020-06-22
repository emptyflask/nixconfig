{ config, lib, pkgs, ... }:
let
  # rofiConfig = builtins.fetchGit {
  #   url = "git@github.com:emptyflask/rofi.git";
  # };

in {
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark";
  };
}
