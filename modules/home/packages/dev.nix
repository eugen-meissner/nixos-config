{ pkgs, ... }:

let
  dotnetCombined = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnetCorePackages.sdk_8_0
    pkgs.dotnetCorePackages.sdk_9_0
    pkgs.dotnetCorePackages.sdk_10_0
  ];
  claudeCodeVersion = "2.1.201";
  claudeCodePlatform =
    "${pkgs.stdenvNoCC.hostPlatform.node.platform}-${pkgs.stdenvNoCC.hostPlatform.node.arch}";
  claudeCode = pkgs.claude-code.overrideAttrs (_finalAttrs: _previousAttrs: {
    version = claudeCodeVersion;
    src = pkgs.fetchurl {
      url = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/${claudeCodeVersion}/${claudeCodePlatform}/claude";
      hash = "sha256-o0gJpoOf3v/yG5NH1/tba1jmqcwgil5ihT8pyD6xB6M=";
    };
  });
  codelldb = pkgs.writeShellScriptBin "codelldb" ''
    exec ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$@"
  '';
  latexindent = pkgs.writeShellScriptBin "latexindent" ''
    exec ${pkgs.texlivePackages.latexindent}/bin/latexindent "$@"
  '';
in {
  home.packages = with pkgs; [
    djlint
    gcc
    gdb
    gnumake
    go
    gopls
    gofumpt
    gotools
    delve
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    claudeCode
    nodePackages_latest.nodejs
    nodePackages_latest.prettier
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    yarn
    python3
    python312Packages.ipython
    dotnetCombined
    roslyn-ls
    lua-language-server
    stylua
    tailwindcss-language-server
    netcoredbg
    codelldb
    terraform
    terraform-ls
    texlab
    latexindent
    redisinsight
    spacetimedb
  ];

  home.sessionVariables = {
    DOTNET_ROOT    = "${dotnetCombined}/share/dotnet";
    DOTNET_ROOT_X64 = "${dotnetCombined}/share/dotnet";
  };
}
