{ pkgs, ... }:
{
  services.udev.packages = with pkgs; [
    rpcs3
    yubikey-personalization
  ];

  security = {
    rtkit.enable = true;
    sudo.enable = true;

    pam.services = {
      hyprlock = { };
    };
  };
}
