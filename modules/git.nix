{ ... }:

{
  programs.git = {
    enable = true;

    # signing.key = "B490B254BDB9D657B7D6695B1B14FF4E55A4EB54";

    settings = {
      user = {
        name = "Victor Jacobs";
        email = "victor@vjcbs.be";
      };

      alias = {
        co = "checkout";
        h = "rev-parse HEAD";
      };

      core = {
        pager = "diff-so-fancy | less --tabs=4 -RFX";
      };

      init = {
        defaultBranch = "main";
      };

      push.default = "current";
      url."git@github.com:".insteadOf = "https://github.com/";
      pull.rebase = false;
    };
  };
}
