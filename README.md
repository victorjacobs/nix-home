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
