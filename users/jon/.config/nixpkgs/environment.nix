{pkgs, ...}:

{
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING=1;

    ACK_COLOR_MATCH="red";

    EDITOR   = "nvim";
    LESS     = "-F -R -M -i";
    LESSOPEN = "| ${pkgs.sourceHighlight}/bin/src-hilite-lesspipe.sh %s";
    MANPAGER = "nvim -c 'set ft=man' -";
    PAGER    = "less";
  };
}
