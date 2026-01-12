{ config, pkgs, ... }:

{
  # TODO this depends on operating system
  home.username = "victor";
  home.homeDirectory = "/Users/victor";

  home.file.".vimrc".source = ./vimrc;
  home.file.".zshrc".source = ./zshrc;
  home.file.".editorconfig".source = ./editorconfig;

  home.packages = with pkgs; [
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
  ];

  programs.git = {
    enable = true;
    userName = "Victor Jacobs";
    userEmail = "victor@vjcbs.be";

    signing.key = "B490B254BDB9D657B7D6695B1B14FF4E55A4EB54";

    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status -sb";
      br = "branch";
      lo = "log --oneline";
      dt = "difftool";
      df = "diff";
      h = "rev-parse HEAD";
    };

    extraConfig = {
      core = {
        pager = "diff-so-fancy | less --tabs=4 -RFX";
        editor = "vim";
      };
      diff.tool = "vimdiff";
      difftool.prompt = false;
      init = {
        templatedir = "~/.git_template";
        defaultBranch = "main";
      };
      push.default = "current";
      url."git@github.com:".insteadOf = "https://github.com/";
      pull.rebase = false;
    };
  };

  home.stateVersion = "25.11";
}
