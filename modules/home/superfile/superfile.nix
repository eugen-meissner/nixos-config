{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  # Build superfile using buildGoModule to handle dependencies properly
  # This avoids the vendor directory issues with the flake's build
  superfile = pkgs.buildGoModule rec {
    pname = "superfile";
    version = "1.5.0";
    # Get source from the flake input
    src = inputs.superfile;
    # Vendor hash calculated by Nix (from the error message)
    vendorHash = "sha256-wOxejOv2XLyzl9ZSkhI2OYMQ7yWeKxSdyFjm/dKe+Ag=";
    doCheck = false;
  };
in
{
  home.packages = [ superfile ];

  xdg.desktopEntries.superfile = {
    name = "Superfile";
    genericName = "File Manager";
    comment = "Open directories in superfile";
    exec = "ghostty -e superfile %f";
    mimeType = [ "inode/directory" ];
    categories = [
      "ConsoleOnly"
      "FileManager"
      "System"
    ];
    terminal = false;
  };

  xdg.configFile."superfile/config.toml".source = ./config.toml;
}
