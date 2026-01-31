{ pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
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
          host_color="yellow"
      else
          host_display=""
          host_color="green"
      fi

      PROMPT="[%F{$host_color}%n''${host_display}%f:%F{cyan}%~%f]%# "
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
}
