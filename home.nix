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
      tailscale =
        if isDarwin then "/Applications/Tailscale.app/Contents/MacOS/Tailscale" else "tailscale";
    };

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      # Custom Functions
      function hm () {
          home-manager --flake ~/dev/nix-home#vjacobs-${if isDarwin then "mac" else "linux"} $@
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

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = builtins.readFile ./.vimrc;
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
