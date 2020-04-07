{ config, lib, pkgs, ... }:
{
  accounts.email.accounts = {
    "jon@emptyflask.net" = {
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
      passwordCommand = "${pkgs.password-store}/bin/pass jon@emptyflask.net";
      # neomutt = {
      #   enable = true;
      #   extraConfig = ''
      #     color status cyan default
      #   '';
      # };
    };
  };
}
