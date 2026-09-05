# nix-home

```bash
nix run home-manager/master -- switch --flake .#vjacobs
home-manager switch --flake ~/nix-config
```

Codex is overlaid in `overlays/codex.nix` so it can be updated independently of
nixpkgs. The overlay supports Apple Silicon macOS (`aarch64-darwin`) and Linux
amd64 (`x86_64-linux`).

To update it, change the version and update `hash` and `codeModeHostHash` for
each platform in `releases`. Fetch each platform's `codex` and
`codex-code-mode-host` archives with `nix store prefetch-file --json <release-url>`
and use the returned hashes. Then run the switch command below on macOS.

```bash
home-manager switch --flake .#vjacobs-mac
```

## tmux for remote Codex sessions

Run tmux on the remote machine so Codex keeps running when SSH disconnects:

```bash
ssh your-host
tmux new-session -A -s codex
codex
```

On reconnect, run `tmux new-session -A -s codex` again to attach to the existing
session. Use a different session name for each project. The tmux configuration
is shared by macOS and Linux through `home.nix`.

The prefix is the default `Ctrl-b`, followed by:

- `d`: detach, leaving the session running.
- `c`: new window in the current directory; `n` / `p`: next / previous window.
- `|` / `-`: split side by side / top and bottom; arrow keys: change pane.
- `z`: zoom or unzoom the current pane; `s`: choose a session.
- `[`: copy mode (`/` to search, `v` to select, `y` to copy, `q` to leave).
- `]`: paste the tmux buffer. System clipboard copying depends on terminal OSC 52 support.

Mouse scrolling and 100,000 lines of history are enabled. Failed panes remain
visible for inspection; use `tmux respawn-pane` to restart one or prefix `x` to
close it. tmux survives SSH disconnects, but not a remote reboot or a host policy
that kills processes on logout.
