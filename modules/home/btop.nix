{ host, pkgs, ... }:
{
  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      rocmSupport = host == "desktop";
    };

    settings = {
      color_theme = "TTY";
      custom_gpu_name0 = "AMD Radeon RX 7800 XT";
      theme_background = false;
      update_ms = 500;
      rounded_corners = false;
    };
  };

  home.packages = with pkgs; [ nvtopPackages.intel ];
}
