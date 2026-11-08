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
      settings.editorconfig = true;
    };

    deno = {
      enable = true;
      includes = [
        "*.md"
      ];
      priority = 60;
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
}
