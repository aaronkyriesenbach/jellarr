{
  lib,
  pkgs,
  ...
}: let
  version = "0.2.0"; # x-release-please-version

  # Only the manifest and lockfile feed the dependency hash, so editing source
  # files does not invalidate it.
  nodeModules = pkgs.stdenvNoCC.mkDerivation {
    pname = "jellarr-node-modules";
    inherit version;

    src = lib.fileset.toSource {
      root = ../.;
      fileset = lib.fileset.unions [
        ../package.json
        ../bun.lock
      ];
    };

    nativeBuildInputs = [pkgs.bun];

    dontConfigure = true;
    dontFixup = true;

    buildPhase = ''
      runHook preBuild
      export HOME=$TMPDIR
      export BUN_INSTALL_CACHE_DIR=$TMPDIR/bun-cache
      # Install optional platform binaries for every os/cpu so the output hash
      # is identical on all systems.
      bun install --frozen-lockfile --ignore-scripts --no-progress \
        --os='*' --cpu='*'
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r node_modules $out/node_modules
      runHook postInstall
    '';

    outputHash = "sha256-bzrJDIRWj7Rt8g4zIFnMXindFt196cPt2uSRQYpJUgM=";
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };
in
  pkgs.stdenvNoCC.mkDerivation {
    pname = "jellarr";
    inherit version;

    src = ../.;

    nativeBuildInputs = [
      pkgs.bun
      pkgs.makeBinaryWrapper
      pkgs.nodejs_24
    ];

    CI = "true";

    configurePhase = ''
      runHook preConfigure
      export HOME=$TMPDIR
      cp -r ${nodeModules}/node_modules node_modules
      chmod -R u+w node_modules
      runHook postConfigure
    '';

    buildPhase = ''
      runHook preBuild
      bun run build
      runHook postBuild
    '';

    checkPhase = ''
      runHook preCheck
      bun run test
      runHook postCheck
    '';

    installPhase = ''
      runHook preInstall
      install -Dm644 -t $out/share bundle.cjs
      makeWrapper ${lib.getExe pkgs.nodejs_24} $out/bin/jellarr \
        --add-flags "$out/share/bundle.cjs"
      runHook postInstall
    '';

    meta = {
      description = "Declarative Jellyfin configuration engine (TypeScript, bundled)";
      homepage = "https://github.com/aaronkyriesenbach/jellarr";
      license = lib.licenses.agpl3Only;
      mainProgram = "jellarr";
      platforms = lib.platforms.all;
    };
  }
