_final: prev: {
  codex = prev.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.153.4";

    src = prev.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-aarch64-apple-darwin.tar.gz";
      hash = "sha256-jPkR6mdlI7+yEh7FYYSNKrpWSJCtU2202KM1PyuYULE=";
    };

    codeModeHost = prev.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-code-mode-host-aarch64-apple-darwin.tar.gz";
      hash = "sha256-Ramw/fU7mLhaa7keF13ZDpYTKKehT7UKQJAiBRmd8d8=";
    };

    sourceRoot = ".";
    dontConfigure = true;
    dontBuild = true;

    nativeBuildInputs = [prev.makeBinaryWrapper];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      install -m755 codex-aarch64-apple-darwin $out/bin/codex
      tar -xzf $codeModeHost
      install -m755 codex-code-mode-host-aarch64-apple-darwin $out/bin/codex-code-mode-host
      wrapProgram $out/bin/codex --prefix PATH : ${prev.lib.makeBinPath [prev.ripgrep]}

      runHook postInstall
    '';

    meta =
      prev.codex.meta
      // {
        sourceProvenance = [prev.lib.sourceTypes.binaryNativeCode];
      };
  };
}
