{ pkgs, ...}:

let
  unstable = import <nixos-unstable> {};
in

with pkgs;

{ 
  programs.neovim = {
    enable    = true;
    package   = unstable.neovim-unwrapped;

    viAlias   = true;
    vimAlias  = false;

    configure = {
      customRC = (builtins.readFile ../vim/vimrc) + ''
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1 
        filetype plugin indent on

        let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
        let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
        let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
        let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
        let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
        let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
        let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
      '';

      plug.plugins = with pkgs.vimPlugins; [
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
        # vim-hindent
        vim-nix
        vim-polyglot
        vim-snippets
        vim-speeddating
        vim-startify
        vim-test
        vim-unimpaired
        vimproc
        vimwiki
      ];

    };
  };
}
