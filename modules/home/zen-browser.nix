{ inputs, pkgs, lib, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  zenPkg = inputs.zen-browser.packages.${system}.beta;
  # Desktop override dir: same filename(s) as package, Exec set to use native Wayland scaling.
  zenDesktopOverride = pkgs.runCommand "zen-beta-desktop-wayland" { } ''
    mkdir -p $out
    shopt -s nullglob
    for f in "${zenPkg}"/share/applications/*.desktop; do
      name=$(basename "$f")
      sed 's|^Exec=.*|Exec=env MOZ_ENABLE_WAYLAND=1 zen-beta %u|' "$f" > "$out/$name"
    done
  '';
in
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  # Override Zen desktop file so launchers do not force it onto XWayland.
  home.activation.zenDesktopWayland = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/.local/share/applications"
    run cp -f "${zenDesktopOverride}"/* "$HOME/.local/share/applications/"
  '';

  # Migrate Zen config from ~/.zen to ~/.config/zen (required as of 18.18.6b). Runs on switch when ~/.zen exists.
  home.activation.zenBrowserXdgMigration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/.zen" ]; then
      echo "Migrating Zen Browser config: ~/.zen -> ~/.config/zen"
      run mkdir -p "$HOME/.config/zen"
      run cp -an "$HOME/.zen"/. "$HOME/.config/zen/"
      run rm -rf "$HOME/.zen"
      for f in "$HOME/.config/zen/extensions.json" "$HOME/.config/zen/pkcs11.txt" "$HOME/.config/zen/chrome_debugger_profile/pkcs11.txt"; do
        if [ -f "$f" ]; then
          run sed -i 's|\.zen|\.config/zen|g' "$f"
        fi
      done
      echo "Done. Run: zen-beta --safe-mode (once), then close the browser."
    fi
  '';

}
