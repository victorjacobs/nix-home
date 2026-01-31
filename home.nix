{
  config,
  pkgs,
  lib,
  ...
}:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  programs.home-manager.enable = true;

  imports = [
    ./modules/zsh.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/ssh.nix
    ./modules/vim.nix
  ];

  home.file.".editorconfig".source = ./.editorconfig;

  home.packages = with pkgs; [
    ripgrep
    jq
    yq-go
    eza
    diff-so-fancy
    tldr
    kubectl
  ];

  # $PATH
  home.sessionPath = [
    "$HOME/bin"
    "$HOME/go/bin"
  ];

  # Environment variables
  home.sessionVariables = {
    GOPATH = "$HOME/go";
    SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };

  home.stateVersion = "25.11";
}
