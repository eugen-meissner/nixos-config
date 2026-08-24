{ host, ... }:
let
  palette = import ./palette.nix;
  ansi = palette.ansi;
  a = i: builtins.substring 1 6 (builtins.elemAt ansi i);
  hex = c: builtins.substring 1 6 c;
in
{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "Iosevka Nerd Font Mono:size=${if (host == "laptop") then "12" else "14"}";
      };

      colors = {
        alpha = 0.9;
        background = hex palette.bg;
        foreground = hex palette.fgBright;

        regular0 = a 0; # black
        regular1 = a 1; # red
        regular2 = a 2; # green
        regular3 = a 3; # yellow
        regular4 = a 4; # blue
        regular5 = a 5; # magenta
        regular6 = a 6; # cyan
        regular7 = a 7; # white

        bright0 = a 8;
        bright1 = a 9;
        bright2 = a 10;
        bright3 = a 11;
        bright4 = a 12;
        bright5 = a 13;
        bright6 = a 14;
        bright7 = a 15;
      };
    };
  };
}
