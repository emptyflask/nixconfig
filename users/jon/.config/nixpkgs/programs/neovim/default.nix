{pkgs, ...}:
# let
#   pkgs = import <nixos-unstable> {};
# in

with pkgs;

{

  programs.neovim = {
    enable    = true;
    package   = neovim-unwrapped;

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
    ]) + ''
      let g:coc_data_home = "~/.config/coc"
      let g:gitgutter_git_executable = "${git}/bin/git"
    '';

    plugins = with vimPlugins; [
      Hoogle
      Rename
      Tabular
      Tagbar
      coc-json
      coc-nvim
      coc-solargraph
      coc-tslint
      elm-vim
      fastfold
      fugitive
      fzf-vim
      fzfWrapper
      ghc-mod-vim
      gitgutter
      gruvbox-community
      # hlint-refactor
      # intero-neovim
      lightline-vim
      # neco-ghc
      neoformat
      repeat
      sensible
      tlib
      undotree
      vim-abolish
      vim-commentary
      vim-dispatch
      vim-grepper
      vim-gutentags
      vim-polyglot  # syntax highlighting for most languages
      vim-sandwich
      vim-snippets
      vim-speeddating
      vim-startify
      vim-stylish-haskell
      vim-test
      vim-tmux-navigator
      vim-unimpaired
      vimproc
      vimwiki
    ];

  };
}
