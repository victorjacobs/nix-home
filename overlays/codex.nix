_final: prev: let
  releases = {
    aarch64-darwin = {
      target = "aarch64-apple-darwin";
      hash = "sha256-NEMQoKWRwbGS4E/v8wQyGmmQfJSYuqrDMcp+FuvO+dc=";
      codeModeHostHash = "sha256-UA7ioC6lmK5RkFLn19jiAdHbAZhvMMIU70FDZF3Ib60=";
    };
    x86_64-linux = {
      target = "x86_64-unknown-linux-musl";
      hash = "sha256-1+GLJZeujyQvXzHunpDe70jbye3WNNmGj7ZDXQjAfwI=";
      codeModeHostHash = "sha256-po33zKI8bafN4XVnfffeYcc6I0rdEzOhJUuG1kGvAfc=";
    };
  };
  release = releases.${prev.stdenv.hostPlatform.system};
in {
  codex = prev.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.154.0";

    src = prev.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-${release.target}.tar.gz";
      inherit (release) hash;
    };

    codeModeHost = prev.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-code-mode-host-${release.target}.tar.gz";
      hash = release.codeModeHostHash;
    };

    sourceRoot = ".";
    dontConfigure = true;
    dontBuild = true;

    nativeBuildInputs = [prev.makeBinaryWrapper];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      install -m755 codex-${release.target} $out/bin/codex
      tar -xzf $codeModeHost
      install -m755 codex-code-mode-host-${release.target} $out/bin/codex-code-mode-host
      wrapProgram $out/bin/codex --prefix PATH : ${prev.lib.makeBinPath [prev.ripgrep]}

      runHook postInstall
    '';

    meta =
      prev.codex.meta
      // {
        sourceProvenance = [prev.lib.sourceTypes.binaryNativeCode];
        platforms = builtins.attrNames releases;
      };
  };
}
