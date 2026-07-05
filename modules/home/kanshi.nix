{ pkgs, ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "DP-5";
            mode = "2560x1440@120.00000Hz";
            position = "2560,0";
            scale = 1.0;
            status = "enable";
          }
          {
            criteria = "DP-8";
            mode = "2560x1440@120.00000Hz";
            position = "0,0";
            scale = 1.0;
            status = "enable";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
    ];
  };
}
