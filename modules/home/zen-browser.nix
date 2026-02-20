{ inputs, pkgs, lib, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  zenPkg = inputs.zen-browser.packages.${system}.beta;
  # Desktop override dir: same filename(s) as package, Exec set to use XWayland (fixes IPDL error)
  zenDesktopOverride = pkgs.runCommand "zen-beta-desktop-xwayland" { } ''
    mkdir -p $out
    shopt -s nullglob
    for f in "${zenPkg}"/share/applications/*.desktop; do
      name=$(basename "$f")
      sed 's|^Exec=.*|Exec=env MOZ_ENABLE_WAYLAND=0 zen-beta %u|' "$f" > "$out/$name"
    done
  '';
in
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser.suppressXdgMigrationWarning = true;
  programs.zen-browser.enable = true;

  # Override Zen desktop file so it launches with MOZ_ENABLE_WAYLAND=0 (fixes IPDL invalid file descriptor)
  home.activation.zenDesktopXwayland = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
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

  xdg.mimeApps =
    let
      value =
        let
          system = pkgs.stdenv.hostPlatform.system;
          zen-browser = inputs.zen-browser.packages.${system}.beta;
        in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (
        map (name: { inherit name value; }) [
          "application/x-extension-shtml"
          "application/x-extension-xhtml"
          "application/x-extension-html"
          "application/x-extension-xht"
          "application/x-extension-htm"
          "x-scheme-handler/unknown"
          "x-scheme-handler/mailto"
          "x-scheme-handler/chrome"
          "x-scheme-handler/about"
          "x-scheme-handler/https"
          "x-scheme-handler/http"
          "application/xhtml+xml"
          "application/json"
          "text/html"
        ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };
}
