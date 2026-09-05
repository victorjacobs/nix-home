_final: prev: let
  releases = {
    aarch64-darwin = {
      target = "aarch64-apple-darwin";
      hash = "sha256-jPkR6mdlI7+yEh7FYYSNKrpWSJCtU2202KM1PyuYULE=";
      codeModeHostHash = "sha256-Ramw/fU7mLhaa7keF13ZDpYTKKehT7UKQJAiBRmd8d8=";
    };
    x86_64-linux = {
      target = "x86_64-unknown-linux-musl";
      hash = "sha256-9HlCTsoJJITcQNh64oxE9MxAI0pgBF1hMeSTgA2BSjA=";
      codeModeHostHash = "sha256-+VgwqGlZCVdmS7/Ge8ywh3OAa2k2cLrxWQgXb4m0zTE=";
    };
  };
  release = releases.${prev.stdenv.hostPlatform.system};
in {
  codex = prev.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.153.4";

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
