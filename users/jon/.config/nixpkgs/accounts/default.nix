{ config, lib, pkgs, ... }:

{
  # programs.mbsync.enable = true;
  programs.offlineimap.enable = true;
  # programs.msmtp.enable = true;
  # programs.notmuch = {
  #   enable = true;
  #   hooks = {
  #     preNew = "mbsync --all";
  #   };
  # };

  accounts.email.accounts = {

    emptyflask = {
      primary = true;
      address = "jon@emptyflask.net";
      realName = "Jon Roberts";
      signature = {
        showSignature = "append";
        text = ''
            --
            Jon Roberts
        '';
      };
      aliases = [
        "events@emptyflask.net"
        "throwaway@emptyflask.net"
      ];
      flavor = "gmail.com";
      userName = "jon@emptyflask.net";
      passwordCommand = "${pkgs.pass}/bin/pass jon@emptyflask.net";
      neomutt = {
        enable = true;
        extraConfig = ''
          color status cyan default
        '';
      };
      # imap.host = "emptyflask.net";
      # smtp.host = "emptyflask.net";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      notmuch.enable = true;
      offlineimap.enable = true;
    };

    sxsw = {
      primary = false;
      address = "jon@sxsw.com";
      realName = "Jon Roberts";
      signature = {
        showSignature = "append";
        text = ''
            --
            Jon Roberts
            SXSW | Lead Developer
            512 828-7363
        '';
      };
      flavor = "gmail.com";
      userName = "jon@sxsw.com";
      passwordCommand = "${pkgs.pass}/bin/pass jon@sxsw.com";
      neomutt = {
        enable = true;
        extraConfig = ''
          color status green default
        '';
      };
      mbsync = {
        enable = true;
        create = "maildir";
      };
      notmuch.enable = true;
      offlineimap.enable = true;
    };

  };
}
