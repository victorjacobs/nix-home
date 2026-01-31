{ pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.vim = {
    enable = false;
    defaultEditor = true;
    extraConfig = builtins.readFile ../.vimrc;
    plugins =
      with pkgs.vimPlugins;
      [
        vim-commentary
        lightline-vim
        auto-pairs
        vim-markdown
        nerdtree
        vim-visual-star-search
        vim-json
        editorconfig-vim
        (pkgs.vimUtils.buildVimPlugin {
          name = "peaksea";
          src = pkgs.fetchFromGitHub {
            owner = "vim-scripts";
            repo = "peaksea";
            rev = "2051d4e5384b94b4e258b059e959ffb5202dec11";
            sha256 = "sha256-b+EQTh02DD9clqROhtwcdnOiVcnyYCJytHFoHv/6w4E=";
          };
        })
      ]
      ++ (
        if isDarwin then
          [
            vim-expand-region
            fzf-vim
            vim-multiple-cursors
            vim-gitgutter
            vim-go
            vim-fugitive
            nerdtree-git-plugin
            undotree
            ale
            csv-vim
            vim-polyglot
            vim-unimpaired
            vim-endwise
            ctrlp-vim
          ]
        else
          [ ]
      );
  };
}
