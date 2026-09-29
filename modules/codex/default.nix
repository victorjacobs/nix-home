{...}: {
  home.file.".codex/AGENTS.md".source = ./AGENTS.md;
  home.file.".codex/skills" = {
    source = ./skills;
    recursive = true;
  };
}
