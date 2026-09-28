_final: prev: let
  releases = {
    aarch64-darwin = {
      target = "aarch64-apple-darwin";
      hash = "sha256-NBxKCPnOGTWzAHN23Co9UKCokRKTDppHSuYTZyGPboo=";
      codeModeHostHash = "sha256-GTY5GNp19dK4Bbb/+v2E6jyJduA+dRGSwErqW9cNSrQ=";
    };
    x86_64-linux = {
      target = "x86_64-unknown-linux-musl";
      hash = "sha256-r59apuZmKsz51wfO8NnKCDiAoXOpwrbCKUftt4MOV3g=";
      codeModeHostHash = "sha256-VFXGS+S6NxREcQiVr/bXTWU5haO/xFSot/5C1ubRHj0=";
    };
  };
  release = releases.${prev.stdenv.hostPlatform.system};
in {
  codex = prev.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.158.0";

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
