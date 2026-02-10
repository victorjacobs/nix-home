{ ... }:

{
  editorconfig = {
    enable = true;

    settings = {
      "*" = {
        indent_style = "space";
        indent_size = 4;
        insert_final_newline = true;
        trim_trailing_whitespace = true;
      };
      "*.go" = {
        indent_style = "tab";
        indent_size = 2;
      };
      "*.{json,md,yaml,yml,js,rb,lua,nix,proto}" = {
        indent_size = 2;
      };
    };
  };
}
