{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ledger-live-desktop
    obs-studio
    transmission_4-gtk
    thunderbird
  ];
}
