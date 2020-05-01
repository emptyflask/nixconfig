{ pkgs, ...}:

{
  programs.mbsync.enable = true;

  programs.neomutt = {
    enable  = true;
    vimKeys = true;

    sidebar.enable = true;

  };
}
