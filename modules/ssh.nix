{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*.vjcbs.be" = {
        user = "vjacobs";
      };
    };
  };
}
