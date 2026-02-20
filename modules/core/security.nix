{ pkgs, ... }:
{
  
  services.udev.packages = [ pkgs.yubikey-personalization ];

  security = {
    rtkit.enable = true;
    sudo.enable = true;

    pam.services = {
      swaylock = { };
      hyprlock = { };
    };
  };
}
