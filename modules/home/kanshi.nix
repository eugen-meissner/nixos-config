{ pkgs, ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "docked";
        profile.exec = [
          "${pkgs.hyprland}/bin/hyprctl dispatch dpms off eDP-1"
        ];
        profile.outputs = [
          {
            criteria = "DP-1";
            mode = "5120x2880@60.00000Hz";
            position = "0,0";
            scale = 2.0;
            status = "enable";
          }
          {
            criteria = "DP-2";
            status = "disable";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      {
        profile.name = "undocked";
        profile.exec = [
          "${pkgs.hyprland}/bin/hyprctl dispatch dpms on eDP-1"
        ];
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
            scale = 1.0;
            status = "enable";
          }
        ];
      }
    ];
  };
}
