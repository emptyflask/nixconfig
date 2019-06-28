{ pkgs, ...}:

with pkgs;

{ 
  programs.neovim = {
    enable    = true;
    viAlias   = true;
    vimAlias  = true;

    configure = {
      customRC = (builtins.readFile ../vim/vimrc);

      packages.myVimPackage = with pkgs.vimPlugins; {

        # loaded on launch
        start = [ 
          Hoogle
          LanguageClient-neovim
          Rename
          Tabular
          Tagbar
          ale
          deoplete-nvim
          elm-vim
          fastfold
          fugitive
          fzf-vim
          fzfWrapper
          ghc-mod-vim
          gitgutter
          gruvbox
          haskell-vim
          hlint-refactor
          intero-neovim
          lightline-vim
          neco-ghc
          neosnippet
          neosnippet-snippets
          repeat
          sensible
          surround
          tlib
          undotree
          vim-commentary
          vim-dispatch
          vim-elixir
          vim-go
          vim-grepper
          vim-gutentags
          vim-hindent
          vim-nix
          vim-snippets
          vim-speeddating
          vim-startify
          vim-test
          vim-toml
          vim-unimpaired
          vimproc
          vimwiki
          # gtags.vim
          # html5.vim
          # vim-endwise
          # vim-handlebars           { 'for': 'handlebars.html' }
          # vim-projectroot
          # vim-ref
          # vim-sneak             " move using sXX / XzXX
          # vim-togglelist
        ];

        # manually loadable by calling `:packadd $plugin-name`
        opt = [ ];

      };
    };
  };
}
