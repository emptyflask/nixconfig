{ pkgs, ... }:
with pkgs;
{
  xresources.properties = {

    # colors
    "*.cursorColor"         = "#ebdbb2";
    "*.background"          = "#1d2021";
    "*.foreground"          = "#ebdbb2";

    # black
    "*.color0"              = "#282828";
    "*.color8"              = "#928374";

    # red
    "*.color1"              = "#cc241d";
    "*.color9"              = "#fb4934";

    # green
    "*.color2"              = "#98971a";
    "*.color10"             = "#b8bb26";

    # yellow
    "*.color3"              = "#d79921";
    "*.color11"             = "#fabd2f";

    # blue
    "*.color4"              = "#458588";
    "*.color12"             = "#83a598";

    # magenta
    "*.color5"              = "#b16286";
    "*.color13"             = "#d3869b";

    # cyan
    "*.color6"              = "#689d6a";
    "*.color14"             = "#8ec07c";

    # white
    "*.color7"              = "#a89984";
    "*.color15"             = "#ebdbb2";

    # 256 color resources
    "*.color24"             = "#076678";
    "*.color66"             = "#427b58";
    "*.color88"             = "#9d0006";
    "*.color96"             = "#8f3f71";
    "*.color100"            = "#79740e";
    "*.color108"            = "#8ec07c";
    "*.color109"            = "#83a598";
    "*.color130"            = "#af3a03";
    "*.color136"            = "#b57614";
    "*.color142"            = "#b8bb26";
    "*.color167"            = "#fb4934";
    "*.color175"            = "#d3869b";
    "*.color208"            = "#fe8019";
    "*.color214"            = "#fabd2f";
    "*.color223"            = "#ebdbb2";
    "*.color228"            = "#f4e8ba";
    "*.color229"            = "#fdf4c1";
    "*.color230"            = "#ffffc8";
    "*.color234"            = "#1d2021";
    "*.color235"            = "#282828";
    "*.color236"            = "#32302f";
    "*.color237"            = "#3c3836";
    "*.color239"            = "#504945";
    "*.color241"            = "#665c54";
    "*.color243"            = "#7c6f64";
    "*.color244"            = "#928374";
    "*.color245"            = "#928374";
    "*.color246"            = "#a89984";
    "*.color248"            = "#bdae93";
    "*.color250"            = "#d5c4a1";

    # URxvt Fonts
    "URxvt.font"            = "xft:Fira Code:size=11,style=medium,antialias=true";
    "URxvt.boldFont"        = "xft:Fira Code:size=11,style=bold,antialias=true";
    "URxvt.italicFont"      = "xft:Fira Code:size=11,style=bold,antialias=true";
    "URxvt.boldItalicFont"  = "xft:Fira Code:size=11,style=bold,antialias=true";

    # URxvt UI
    "URxvt*borderless"      = true;
    "URxvt.internalBorder"  = 10;
    "URxvt*scrollBar"       = false;
    "URxvt*saveLines"       = 20000;
    "URxvt*dynamicColors"   = true;
    "URxvt*termName"        = "rxvt-unicode";
    "URxvt*fading"          = 10;

    # URxvt Colors
    "URxvt.depth"           = 32;
    "URxvt.intensityStyles" = false;

    # Xft settings
    "Xft.dpi"               = 96;
    "Xft.antialias"         = true;
    "Xft.rgba"              = "rgb";
    "Xft.hinting"           = true;
    "Xft.hintstyle"         = "hintfull";
  };
}
