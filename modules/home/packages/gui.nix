{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    thunderbird
  ];
}
