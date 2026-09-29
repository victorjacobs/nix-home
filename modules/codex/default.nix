{lib, ...}: {
  home.file =
    {".codex/AGENTS.md".source = ./AGENTS.md;}
    // lib.mapAttrs' (name: _:
      lib.nameValuePair ".codex/skills/${name}" {
        # Codex follows skill directory links but skips symlinked SKILL.md files.
        source = ./skills + "/${name}";
      }) (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./skills));
}
