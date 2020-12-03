{ pkgs, ...}:

with pkgs;

{
  programs.alacritty = {
    enable = true;

    settings = {

      font = {
        normal.family      = "Fira Code";
        bold.family        = "Fira Code";
        italic.family      = "Fira Code";
        bold_italic.family = "Fira Code";
      };

      cursor = {
        style         = "Underline";
        vi_mode_style = "Block";
      };

      background_opacity = 0.9;

      # Colors (Gruvbox dark)
      colors = {
        primary = {
          background = "#0d1011";
          # background = "#1d2021";
          # background = "#32302f";
          foreground = "#ebdbb2";
        };

        selection = {
          text       = "#b5b3aa";
          background = "#3c3836";
        };

        # Normal colors
        normal = {
          black   = "#282828";
          red     = "#cc241d";
          green   = "#98971a";
          yellow  = "#d79921";
          blue    = "#458588";
          magenta = "#b16286";
          cyan    = "#689d6a";
          white   = "#a89984";
        };

        # Bright colors
        bright = {
          black   = "#928374";
          red     = "#fb4934";
          green   = "#b8bb26";
          yellow  = "#fabd2f";
          blue    = "#83a598";
          magenta = "#d3869b";
          cyan    = "#8ec07c";
          white   = "#ebdbb2";
        };
      };
    };
  };
}
