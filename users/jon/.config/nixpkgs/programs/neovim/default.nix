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

    withNodeJs = true;

    extraConfig = (lib.strings.concatMapStringsSep "\n" builtins.readFile [
      ./config.vim
      ./coc.vim
      ./haskell.vim
      ./keymap.vim
      ./netrw.vim
      ./rename.vim
      ./status.vim
      ./theme.vim
      ./tmux.vim
    ]);

    plugins = with unstable.vimPlugins; [
      Hoogle
      Rename
      Tabular
      Tagbar
      coc-nvim
      elm-vim
      fastfold
      fugitive
      fzf-vim
      fzfWrapper
      ghc-mod-vim
      gitgutter
      gruvbox-community
      haskell-vim
      hlint-refactor
      intero-neovim
      lightline-vim
      neco-ghc
      neoformat
      repeat
      sensible
      tlib
      undotree
      vim-commentary
      vim-dispatch
      vim-elixir
      vim-go
      vim-grepper
      vim-gutentags
      vim-nix
      vim-polyglot
      vim-sandwich
      vim-snippets
      vim-speeddating
      vim-startify
      vim-test
      vim-tmux-navigator
      vim-unimpaired
      vimproc
      vimwiki
    ];

  };
}
