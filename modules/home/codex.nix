{ pkgs, ... }:
let
  version = "0.142.5";
  system = pkgs.stdenv.hostPlatform.system;
  binaryName =
    if system == "x86_64-linux" then
      "codex-x86_64-unknown-linux-musl"
    else
      throw "Unsupported system for prebuilt codex-cli binary: ${system}";
  asset = "${binaryName}.tar.gz";
  hash =
    if system == "x86_64-linux" then
      "sha256-y5M+w8thv0tfyI7s9eYUmCn6phclNbbvCvsBVL60qrg="
    else
      throw "Missing codex-cli release hash for system: ${system}";
in
{
  home.packages = [
    (pkgs.stdenvNoCC.mkDerivation {
      pname = "codex-cli";
      inherit version;

      src = pkgs.fetchurl {
        url = "https://github.com/openai/codex/releases/download/rust-v${version}/${asset}";
        inherit hash;
      };

      dontUnpack = true;
      nativeBuildInputs = [ pkgs.gnutar ];

      installPhase = ''
        runHook preInstall
        mkdir -p "$out/bin"
        tar -xzf "$src" -C "$out/bin"
        mv "$out/bin/${binaryName}" "$out/bin/codex-cli"
        ln -s "$out/bin/codex-cli" "$out/bin/codex"
        runHook postInstall
      '';
    })
  ];

  home.sessionVariables = {
    PLAYWRIGHT_MCP_EXECUTABLE_PATH = "${pkgs.chromium}/bin/chromium";
  };
}
