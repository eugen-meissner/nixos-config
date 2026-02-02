{ pkgs, ... }:
{
  
  services.udev.packages = [ pkgs.yubikey-personalization ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security = {
    rtkit.enable = true;
    sudo.enable = true;

    pam.services = {
      swaylock = { };
      hyprlock = { };
    };
  };
}
