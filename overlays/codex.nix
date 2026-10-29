_final: prev: let
  releases = {
    aarch64-darwin = {
      target = "aarch64-apple-darwin";
      hash = "sha256-NNEjhNkPjgmwuauqvyoKwCpSCTsTFQSuryghB/VKRLI=";
    };
    x86_64-linux = {
      target = "x86_64-unknown-linux-musl";
      hash = "sha256-6XxEY9fxRmkqlV17DhyM9I+XzU1hbNRcXcqy6Nl0MxY=";
    };
  };
  release = releases.${prev.stdenv.hostPlatform.system};
in {
  codex = prev.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.165.0";

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
