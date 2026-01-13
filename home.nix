{ config, pkgs, ... }:

{
  # TODO this depends on operating system
  home.username = "victor";
  home.homeDirectory = "/Users/victor";

  home.file.".vimrc".source = ./.vimrc;
  home.file.".zshrc".source = ./.zshrc;
  home.file.".editorconfig".source = ./.editorconfig;

  home.packages = with pkgs; [
    git
    vim
    ripgrep
    jq
    yq-go
    eza
    fzf
    zoxide
    diff-so-fancy
    tldr
    git
    direnv
    any-nix-shell
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    # signing.key = "B490B254BDB9D657B7D6695B1B14FF4E55A4EB54";

    settings = {
      user = {
        name = "Victor Jacobs";
        email = "victor@vjcbs.be";
      };

      alias = {
        co = "checkout";
        h = "rev-parse HEAD";
      };

      core = {
        pager = "diff-so-fancy | less --tabs=4 -RFX";
        editor = "vim";
      };

      init = {
        defaultBranch = "main";
      };

      push.default = "current";
      url."git@github.com:".insteadOf = "https://github.com/";
      pull.rebase = false;
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*.vjcbs.be" = {
        user = "vjacobs";
      };
      "u459705.your-storagebox.de" = {
        user = "u459705";
        port = 23;
      };
    };
  };

  home.stateVersion = "25.11";
}
