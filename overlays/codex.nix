_final: prev: let
  releases = {
    aarch64-darwin = {
      target = "aarch64-apple-darwin";
      hash = "sha256-CfKp/eMY+804TxW0hQwbkJMGePSAVke2ve0ZbM8y9ZA=";
    };
    x86_64-linux = {
      target = "x86_64-unknown-linux-musl";
      hash = "sha256-szzUJsmsq5s0xakyALpP6DyOYUwYzl71KyvzZAi44Yw=";
    };
  };
  release = releases.${prev.stdenv.hostPlatform.system};
in {
  codex = prev.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.158.0";

    src = prev.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-package-${release.target}.tar.gz";
      inherit (release) hash;
    };

    sourceRoot = ".";
    dontConfigure = true;
    dontBuild = true;

    # Preserve the upstream binaries and package layout used by daemon bootstrap.
    dontFixup = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -R bin codex-package.json codex-path codex-resources $out/

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
