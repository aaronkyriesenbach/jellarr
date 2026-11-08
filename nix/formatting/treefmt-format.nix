_: {
  projectRootFile = "flake.nix";

  programs = {
    deadnix = {
      enable = true;
      priority = 10;
    };

    statix = {
      enable = true;
      priority = 20;
    };

    alejandra = {
      enable = true;
      priority = 30;
    };

    prettier = {
      enable = true;
      priority = 50;
      settings =
        (removeAttrs (builtins.fromJSON (builtins.readFile ../../.prettierrc.json)) ["plugins"])
        // {editorconfig = true;};
    };

    isort = {
      enable = true;
      includes = [
        "*.py"
      ];
      priority = 70;
      profile = "black";
    };

    black = {
      enable = true;
      includes = [
        "*.py"
      ];
      priority = 80;
    };
  };

  settings.global.excludes = [
    "CHANGELOG.md"
    "bun.lock"
    "flake.lock"
    "generated/**"
  ];
}
