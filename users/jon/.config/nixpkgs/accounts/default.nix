{ config, lib, pkgs, ... }:
{
  accounts.email.accounts = {

    "emptyflask" = {
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

    "sxsw" = {
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
      passwordCommand = "${pkgs.pass}/bin/pass jon@sxsw.com";
      neomutt = {
        enable = true;
        extraConfig = ''
          color status green default
        '';
      };
      notmuch.enable = true;
      offlineimap.enable = true;
    };

  };
}
