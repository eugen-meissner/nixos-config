{ ... }:
let
  palette = import ./palette.nix;
  cava = palette.cava;
  c = i: builtins.elemAt cava i;
in
{
  programs.cava = {
    enable = true;

    settings = {
      color = {
        gradient = 1;
        gradient_count = 8;

        gradient_color_1 = "'${c 0}'"; # deep green
        gradient_color_2 = "'${c 1}'";
        gradient_color_3 = "'${c 2}'";
        gradient_color_4 = "'${c 3}'";
        gradient_color_5 = "'${c 4}'";
        gradient_color_6 = "'${c 5}'";
        gradient_color_7 = "'${c 6}'";
        gradient_color_8 = "'${c 7}'"; # bright green
      };
    };
  };
}
