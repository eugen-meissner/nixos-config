{ lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    settings.monitor = [
      "DP-8,2560x1440@120,0x0,1"
      "DP-5,2560x1440@120,2560x0,1"
      "eDP-1,disable"
      ",preferred,auto,auto"
    ];

    extraConfig = ''
      source = ~/.config/hypr/monitors.conf
      source = ~/.config/hypr/workspaces.conf
    '';
  };

  home.activation.hyprlandWritableOverrides = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/hypr"
    touch "$HOME/.config/hypr/monitors.conf"
    touch "$HOME/.config/hypr/workspaces.conf"
  '';

  home.packages = with pkgs; [ nwg-displays ];
}
