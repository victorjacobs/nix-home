{
  config,
  pkgs,
  ...
}: {
  programs.home-manager.enable = true;

  # Override direnv to skip tests (they fail on macOS)
  nixpkgs.overlays = [
    (final: prev: {
      direnv = prev.direnv.overrideAttrs (old: {
        doCheck = false;
      });
    })
  ];

  imports = [
    ./modules/zsh.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/ssh.nix
    ./modules/vim.nix
    ./modules/editorconfig.nix
    ./modules/ghostty.nix
  ];

  news.display = "silent";

  home = {
    packages = with pkgs;
      [
        nh
        ripgrep
        fzf
        jq
        yq-go
        eza
        diff-so-fancy
        tldr
      ]
      ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
        claude-code

        (pkgs.writeShellScriptBin "zed" ''
          /Applications/Zed.app/Contents/MacOS/cli "$@"
        '')

        (pkgs.writeShellScriptBin "code" ''
          /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code "$@"
        '')
      ];

    # $PATH
    sessionPath = [
      "$HOME/bin"
      "$HOME/go/bin"
    ];

    # Environment variables
    sessionVariables = {
      GOPATH = "$HOME/go";
      SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };

    stateVersion = "25.11";
  };
}
