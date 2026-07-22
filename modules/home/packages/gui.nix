{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chromium
    ledger-live-desktop
    linux-wallpaperengine
    mupen64plus
    obs-studio
    rpcs3
    (retroarch.withCores (cores: with cores; [ ppsspp ]))
    transmission_4-gtk
    thunderbird
  ];

  xdg.configFile."retroarch/system/PPSSPP/assets".source = "${pkgs.ppsspp}/share/ppsspp/assets";
}
