{ lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  # This installation was first created with NixOS 25.05.
  system.stateVersion = lib.mkForce "25.05";

  programs.nh.flake = lib.mkForce "/home/em/nixos-config";

  # Mesa provides the desktop OpenGL/Vulkan stack. ROCm's ICD allows
  # compute applications to use the AMD GPU as well.
  hardware.graphics.extraPackages = lib.mkForce [
    pkgs.rocmPackages.clr.icd
  ];

  # Brother HL-L2350DW printing. Avahi discovers the printer over Wi-Fi;
  # brlaser also provides a model-specific driver for USB or legacy queues.
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.system-config-printer.enable = true;

  # Apply ownership to the secondary drive after its filesystem is mounted.
  systemd.services.data-ownership = {
    description = "Prepare the data drive";
    wantedBy = [ "multi-user.target" ];
    requires = [ "mnt-data.mount" ];
    after = [ "mnt-data.mount" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/install -d -m 0755 -o em -g users /mnt/data /mnt/data/SteamLibrary";
      RemainAfterExit = true;
    };
  };
}
