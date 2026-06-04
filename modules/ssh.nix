_: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "u565771.your-storagebox.de" = {
        Port = 23;
        User = "u565771";
        # Force modern kex algorithms, storagebox somehow wants to use old ones
        KexAlgorithms = "sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org";
      };

      "*.vjcbs.be" = {
        User = "vjacobs";
      };
    };
  };
}
