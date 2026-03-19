{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chromium
    ledger-live-desktop
    obs-studio
    transmission_4-gtk
    thunderbird
  ];
}
