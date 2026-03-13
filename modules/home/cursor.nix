{ pkgs, lib, ... }:
let
  cursorAgentVersion = "2026.02.27-e7d2ef6";
  cursorAgentCli = pkgs.stdenvNoCC.mkDerivation {
    pname = "cursor-agent-cli";
    version = cursorAgentVersion;

    src = pkgs.fetchurl {
      url = "https://downloads.cursor.com/lab/${cursorAgentVersion}/linux/x64/agent-cli-package.tar.gz";
      hash = "sha256-QdNrUbDdA6dBUXa7iqumKsxrK4boySCWxCJ3FR9csqw=";
    };

    sourceRoot = ".";
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/bin" "$out/lib/cursor-agent"
      cp -R dist-package/. "$out/lib/cursor-agent/"

      chmod +x \
        "$out/lib/cursor-agent/cursor-agent" \
        "$out/lib/cursor-agent/cursor-askpass" \
        "$out/lib/cursor-agent/cursorsandbox" \
        "$out/lib/cursor-agent/node" \
        "$out/lib/cursor-agent/rg"

      ln -s ../lib/cursor-agent/cursor-agent "$out/bin/agent"
      ln -s ../lib/cursor-agent/cursor-agent "$out/bin/cursor-agent"
      ln -s ../lib/cursor-agent/cursor-askpass "$out/bin/cursor-askpass"

      runHook postInstall
    '';

    meta = with lib; {
      description = "Cursor Agent CLI";
      homepage = "https://cursor.com/agents";
      license = licenses.unfree;
      mainProgram = "agent";
      platforms = [ "x86_64-linux" ];
    };
  };
in
{
  home.packages = with pkgs; [
    code-cursor
    cursorAgentCli
  ];
}
