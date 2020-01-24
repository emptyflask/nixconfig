{ pkgs, ...}:

with pkgs;

{ 
  programs.vim = {
    enable    = true;

    extraConfig = (builtins.readFile ./vimrc) + ''
      syntax on
      filetype plugin indent on

      let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
      let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
      let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
      let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
      let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
      let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
      let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
    '';

    plugins = with pkgs.vimPlugins; [
      Hoogle
      Rename
      Tabular
      Tagbar
      ale
      # elm-vim
      fastfold
      fugitive
      fzf-vim
      fzfWrapper
      ghc-mod-vim
      gitgutter
      gruvbox
      haskell-vim
      hlint-refactor
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
      # vim-elixir
      # vim-go
      vim-grepper
      vim-gutentags
      vim-hindent
      vim-nix
      # vim-polyglot
      vim-snippets
      vim-speeddating
      vim-startify
      vim-test
      # vim-toml
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
  };
}
