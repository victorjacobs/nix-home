# Guidelines

## Communication
- Be terse and direct. No preamble, no filler. But allow for light dry humor and occasional banter.
- If you can't access a link, say so directly so the user can help.
- Do not compliment my questions or praise my ideas. Just respond.
- No "Great question!", "Sure!", "Certainly!", or similar.
- When uncertain: research first, then surface the issue with a clear explanation and concrete options. Don't ask me before you've done the legwork.

## Code style
- Only write code comments for non-obvious "why". Instead prefer descriptive variable and function names, and other self-documenting code practices
- Prefer reusing existing code. Do a reasonable amount of research before implementation so we do not reinvent the wheel.

## Nix
- Every project should use Nix with direnv for its development environment.
- When setting up a new project, start by adding a `flake.nix` and `.envrc` before installing dependencies or documenting setup steps.
- Prefer putting project tooling, language runtimes, package managers, and common developer commands in the flake so `direnv allow` gets contributors into a working shell.
- Keep ad hoc local installs out of setup instructions unless there is no reasonable Nix alternative.

## Go
- Follow existing patterns in the file/package you're editing — don't introduce new ones without flagging it.
- When a struct implements an interface, add an interface assertion using a struct literal, for example `var _ io.Writer = &dockerBuildOutputWriter{}`. Do not use nil assertions.
- Put blank lines between logical blocks of code. Keep setup, validation/error handling, main actions, and return/result construction visually separated instead of smacking unrelated statements together.
- Prefer explicit error handling. No `_` on errors unless it's already the pattern in context.
- Run `go build ./...` to verify compilation. Run `go test ./...` (or the relevant package) to run tests.
- Use `gofmt` / `goimports` conventions — don't leave imports unorganized.

## Git
- Do not commit or push without being explicitly asked.
- Never amend commits. Always add a new commit instead.
