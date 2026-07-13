{ lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
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
