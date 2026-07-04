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
            mode = "2560x1440@59.95100Hz";
            position = "0,0";
            scale = 1.0;
            status = "enable";
          }
          {
            criteria = "DP-8";
            mode = "2560x1440@59.95100Hz";
            position = "2560,0";
            scale = 1.0;
            status = "enable";
          }
          {
            criteria = "eDP-1";
            mode = "1920x1080@60.02000Hz";
            position = "5120,0";
            scale = 1.5;
            status = "enable";
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
