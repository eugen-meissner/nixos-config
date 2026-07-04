{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chromium
    ledger-live-desktop
    mupen64plus
    obs-studio
    transmission_4-gtk
    thunderbird
  ];
}
