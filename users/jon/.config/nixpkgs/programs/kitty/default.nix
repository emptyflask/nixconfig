{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    keybindings = {
      "ctrl+shift+n" = "new_os_window_with_cwd";
      "ctrl+shift+t" = "new_tab_with_cwd !neighbor";
    };

    settings = {
      font_family        = "Fira Code Regular";
      bold_font          = "Fira Code Bold";
      italic_font        = "Fira Mono Regular Italic";
      bold_italic_font   = "Fira Mono Bold Italic";

      background_opacity = "0.9";
      scrollback_lines   = 10000;
      scrollback_pager   = ''nvim -c 'setlocal ft=man nonumber nolist showtabline=0 foldcolumn=0' -c "autocmd VimEnter * normal G" -'';
      enable_audio_bell  = false;

      pointer_shape_when_grabbed = "beam";

      tab_bar_style      = "powerline";
      tab_title_template = " {index}: {title} ";

      # Gruvbox dark(er)
      background = "#0d1011";
      foreground = "#ebdbb2";

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
      color0  = "#1d2021";
      color1  = "#fb4934";
      color2  = "#b8bb26";
      color3  = "#fabd2f";
      color4  = "#83a598";
      color5  = "#d3869b";
      color6  = "#8ec07c";
      color7  = "#d5c4a1";

      # bright
      color8  = "#665c54";
      color9  = "#fe8019";
      color10 = "#3c3836";
      color11 = "#504945";
      color12 = "#bdae93";
      color13 = "#ebdbb2";
      color14 = "#d65d0e";
      color15 = "#fbf1c7";

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
