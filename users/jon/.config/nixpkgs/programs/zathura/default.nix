{pkgs, ...}:

{
  programs.zathura = {
    enable = true;

    options = {
      # gruvbox-dark
      notification-error-bg       = "#282828"; # bg
      notification-error-fg       = "#fb4934"; # bright:red
      notification-warning-bg     = "#282828"; # bg
      notification-warning-fg     = "#fabd2f"; # bright:yellow
      notification-bg             = "#282828"; # bg
      notification-fg             = "#b8bb26"; # bright:green

      completion-bg               = "#504945"; # bg2
      completion-fg               = "#ebdbb2"; # fg
      completion-group-bg         = "#3c3836"; # bg1
      completion-group-fg         = "#928374"; # gray
      completion-highlight-bg     = "#83a598"; # bright:blue
      completion-highlight-fg     = "#504945"; # bg2

      # Define the color in index mode
      index-bg                    = "#504945"; # bg2
      index-fg                    = "#ebdbb2"; # fg
      index-active-bg             = "#83a598"; # bright:blue
      index-active-fg             = "#504945"; # bg2

      inputbar-bg                 = "#282828"; # bg
      inputbar-fg                 = "#ebdbb2"; # fg

      statusbar-bg                = "#504945"; # bg2
      statusbar-fg                = "#ebdbb2"; # fg

      highlight-color             = "#fabd2f"; # bright:yellow
      highlight-active-color      = "#fe8019"; # bright:orange

      default-bg                  = "#282828"; # bg
      default-fg                  = "#ebdbb2"; # fg
      render-loading              = true;
      render-loading-bg           = "#282828"; # bg
      render-loading-fg           = "#ebdbb2"; # fg

      # Recolor book content's color
      recolor-lightcolor          = "#282828"; # bg
      recolor-darkcolor           = "#ebdbb2"; # fg
      recolor                     = false;
      recolor-keephue             = true;      # keep original color

      # use CLIPBOARD, not PRIMARY
      selection-clipboard = "clipboard";
    };
  };
}
