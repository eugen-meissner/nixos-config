{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    settings.monitor = [
      ",preferred,auto,auto"
      "DP-2,disable"
    ];

    extraConfig = ''
      # hyprlang noerror true
        source = ~/.config/hypr/monitors.conf
        source = ~/.config/hypr/workspaces.conf
      # hyprlang noerror false
    '';
  };

  home.packages = with pkgs; [ nwg-displays ];
}
