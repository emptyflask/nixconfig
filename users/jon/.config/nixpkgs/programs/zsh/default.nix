{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history.extended = true;
    initExtra = builtins.readFile ./zshrc;
    loginExtra = ''
      setopt extendedglob
      bindkey '^R' history-incremental-pattern-search-backward
      bindkey '^F' history-incremental-pattern-search-forward
    '';
    shellAliases = {
      ls = "ls --color -F";
      ll = "ls -l";
      l  = "ls -alh";

      duh="du -csh";
      tailf="tail -f";

      ag=''ag --color-line-number=1\;30 --color-path=1\;32 --color-match=0\;31'';
      grep="grep --color=auto";

      bi="bundle install";
      bu="bundle update";
      be="bundle exec";
      trs="touch tmp/restart.txt";

      crush="pngcrush -d crushed -rem gAMA -rem cHRM -rem iCCP -rem sRGB";
      utf8=''find . -type f | xargs -I {} bash -c "iconv -f utf-8 -t utf-16 {} &>/dev/null || echo {}"'';

      curl_json=''curl -v -H "Content-Type: application/json"'';
      curl_json_post=''curl -v -H "Content-Type: application/json" -X POST'';
      curl_json_put=''curl -v -H "Content-Type: application/json" -X PUT'';
      curl_json_delete=''curl -v -H "Content-Type: application/json" -X DELETE'';
      json="jq '.' -C | more -R";

      m="ncmpcpp";
      ms="mpc";
      mm="mpc toggle";
      mn="mpc next";
      mp="mpc prev";

      # ghc="stack ghc -- -Wall";
      # ghci="stack ghci";
      # runhaskell="stack runhaskell -- -Wall";

      nixgc="nix-collect-garbage -d";
      nixq="nix-env -qaP";
      nixupgrade=''nix-channel --update && nix-env -u \"*\"'';
      nixup="nix-env -u";
      nixrm="nix-env -q | fzf | xargs -I{} nix-env -e {}";

      j="jira ls -a emptyflask";
    };

    sessionVariables = {
      ACK_COLOR_MATCH="red";
      _JAVA_AWT_WM_NONREPARENTING=1;
      EDITOR = "nvim";
      WORDCHARS="*?[]~&;!$%^<>";
    };
  };
}
