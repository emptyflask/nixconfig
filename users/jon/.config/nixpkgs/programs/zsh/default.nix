{pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    defaultKeymap = "viins";
    history.extended = true;
    initExtra = (builtins.readFile ./zshrc) + ''
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
      eval "$(${pkgs.fasd}/bin/fasd --init auto)"
      eval $(${pkgs.coreutils}/bin/dircolors -b $HOME/.cache/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-trapd00r-SLASH-LS_COLORS/LS_COLORS)
      source "$(${pkgs.fzf}/bin/fzf-share)/key-bindings.zsh"
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

      # ghc="stack ghc -- -Wall";
      # ghci="stack ghci";
      # runhaskell="stack runhaskell -- -Wall";

      nixgc="nix-collect-garbage -d";
      nixq="nix-env -qaP";
      nixupgrade=''nix-channel --update && nix-env -u \"*\"'';
      nixup="nix-env -u";
      nixrm="nix-env -q | fzf | xargs -I{} nix-env -e {}";

      j="jira ls -a emptyflask";

      open="xdg-open";
    };

    sessionVariables = {
      ACK_COLOR_MATCH="red";
      _JAVA_AWT_WM_NONREPARENTING=1;
      EDITOR = "nvim";
      WORDCHARS="*?[]~&;!$%^<>";

      FZF_DEFAULT_COMMAND="${pkgs.ripgrep}/bin/rg --files";

      FZF_DEFAULT_OPTS=''
        --color=bg+:#3c3836,bg:#1d2021,spinner:#8ec07c,hl:#83a598
        --color=fg:#bdae93,header:#83a598,info:#fabd2f,pointer:#8ec07c
        --color=marker:#8ec07c,fg+:#ebdbb2,prompt:#fabd2f,hl+:#83a598
      '';

      FZF_ALT_C_OPTS="--preview '${pkgs.tree}/bin/tree -C {} | head -100'";

      FZF_CTRL_T_OPTS=''
        --preview '[[ \$(${pkgs.file}/bin/file --mime {}) =~ binary ]] &&
          echo {} is a binary file ||
          (bat --style=numbers --color=always {} ||
          cat {}) 2> /dev/null | head -100'
      '';
    };
  };
}
