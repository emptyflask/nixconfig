{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      font_family        = "Fira Code Regular";
      bold_font          = "Fira Code Bold";
      italic_font        = "Fira Mono Regular Italic";
      bold_italic_font   = "Fira Mono Bold Italic";

      background_opacity = "0.9";
      scrollback_lines   = 10000;
      enable_audio_bell  = false;

      pointer_shape_when_grabbed = "beam";

      tab_bar_style      = "powerline";
      tab_title_template = " {index}: {title} ";

      # Base16 IR Black - kitty color config
      # Timothée Poisot (http://timotheepoisot.fr)
      background = "#000000";
      foreground = "#b5b3aa";

      url_color  = "#918f88";
      cursor     = "#b5b3aa";

      selection_foreground    = "#b5b3aa";
      selection_background    = "#3c3836";

      active_border_color     = "#6c6c66";
      active_tab_background   = "#75715e";
      active_tab_foreground   = "#272822";
      inactive_tab_background = "#272822";
      inactive_tab_foreground = "#75715e";

      # normal
      color0  = "#000000";
      color1  = "#ff6c60";
      color2  = "#a8ff60";
      color3  = "#ffffb6";
      color4  = "#669bce";
      color5  = "#ff73fd";
      color6  = "#c6c5fe";
      color7  = "#b5b3aa";

      # bright
      color8  = "#6c6c66";
      color9  = "#ff6c60";
      color10 = "#a8ff60";
      color11 = "#ffffb6";
      color12 = "#96cbfe";
      color13 = "#ff73fd";
      color14 = "#c6c5fe";
      color15 = "#b5b3aa";

      # extended base16 colors
      color16 = "#e9c062";
      color17 = "#b18a3d";
      color18 = "#242422";
      color19 = "#484844";
      color20 = "#918f88";
      color21 = "#d9d7cc";
    };
  };
}
