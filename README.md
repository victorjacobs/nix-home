# nix-home

```bash
nix run home-manager/master -- switch --flake .#vjacobs
home-manager switch --flake ~/nix-config
```

Codex is overlaid in `overlays/codex.nix` so it can be updated independently of
nixpkgs.

To update it, change the version and replace both release asset hashes with
`lib.fakeHash`. Run the switch command below, then replace each fake hash with
the `got` hash reported by Nix and rerun it.

```bash
home-manager switch --flake .#vjacobs-mac
```
