_: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "u565771.your-storagebox.de" = {
        port = 23;
        user = "u565771";
        # Force modern kex algorithms, storagebox somehow wants to use old ones
        extraOptions = {
          "KexAlgorithms" = "sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org";
        };
      };

      "*.vjcbs.be" = {
        user = "vjacobs";
      };
    };
  };
}
