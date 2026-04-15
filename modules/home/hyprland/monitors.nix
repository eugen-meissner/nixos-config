{ lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    settings.monitor = [
      "DP-1,5120x2880@60,auto,2"
      ",preferred,auto,auto"
      "DP-2,disable"
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
