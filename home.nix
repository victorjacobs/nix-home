{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  # TODO this depends on operating system
  home.username = "victor";
  home.homeDirectory = "/Users/victor";

  home.file.".vimrc".source = ./.vimrc;
  home.file.".editorconfig".source = ./.editorconfig;

  home.packages = with pkgs; [
    vim
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
    EDITOR = "vim";
    GOPATH = "$HOME/go";
  };

  programs.zsh = {
    enable = true;

    # vim mode
    defaultKeymap = "viins"; # Equivalent to set -o vi

    history = {
      size = 1000000000;
      save = 1000000000;
      share = true;
      append = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      extended = true;
    };

    shellAliases = {
      ls = "eza -l";
      k = "kubectl";
      tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
    };

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      # Custom Functions
      function hm () {
          home-manager --flake ~/dev/nix-home#vjacobs $@
      }

      function gir () {
          cd $(git rev-parse --show-cdup)
      }

      # GPG TTY
      export GPG_TTY=$(tty)

      # Keybinding fixes for Vim mode (Backspace issues)
      bindkey -v '^?' backward-delete-char

      # Prompt configuration, if starship is disabled, this gets used
      if [[ -n "$SSH_CONNECTION" ]]; then
          host_display="@%m"
      else
          host_display=""
      fi

      # Only set this fallback prompt if Starship is not active/rendering
      PROMPT="[%F{green}%n''${host_display}%f:%F{cyan}%~%f]%# "
    '';
  };

  programs.nix-your-shell = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = false;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

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
