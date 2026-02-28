{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    zsh.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryFlavor = "";
    };

    nix-ld.enable = true;
    # Allow Playwright's bundled Chromium to resolve its runtime deps on NixOS.
    nix-ld.libraries = with pkgs; [
      glib
      nss
      nspr
      dbus
      atk
      at-spi2-atk
      cups
      expat
      libdrm
      libgbm
      libxkbcommon
      alsa-lib
      pango
      cairo
      gtk3
      stdenv.cc.cc
      libx11
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxcb
      libxshmfence
      libxi
      libxtst
      libxcursor
    ];
  };
}
