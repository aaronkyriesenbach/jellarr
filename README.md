# Jellarr

Declarative configuration management for [Jellyfin](https://jellyfin.org).
Describe your server in a YAML file and Jellarr applies it through Jellyfin's
official REST API. Inspired by
[Configarr](https://github.com/raydak-labs/configarr).

> **Project status:** the original project (`venkyr77/jellarr`) is no longer
> maintained. This fork is actively maintained and accepts pull requests.
>
> Jellarr is developed and supported as a container image. The Nix flake and
> NixOS module are community-maintained: changes are welcome and will be
> reviewed, but they are not actively used or improved by the maintainer.

## Features

- Uses the Jellyfin REST API only. It never edits Jellyfin's files or database,
  and Jellyfin keeps running.
- Idempotent. Only the fields you specify are changed, so it is safe to run on a
  schedule.
- Manages system settings, encoding, libraries, branding, users, plugins, and
  the startup wizard.
- Validates the config with Zod and uses types generated from Jellyfin's OpenAPI
  spec.
- Can export an existing server's configuration as a starting point (`dump`,
  experimental).

## Quick start

Create `config/config.yml`:

```yaml
version: 1
base_url: 'http://jellyfin:8096'
system:
  enableMetrics: true
  pluginRepositories:
    - name: 'Jellyfin Official'
      url: 'https://repo.jellyfin.org/releases/plugin/manifest.json'
      enabled: true
encoding:
  enableHardwareEncoding: true
  hardwareAccelerationType: 'vaapi'
  vaapiDevice: '/dev/dri/renderD128'
```

Create an API key in Jellyfin (Dashboard > API Keys) and run the container:

```bash
docker run --rm \
  -e JELLARR_API_KEY=your_api_key \
  -v ./config:/config:ro \
  ghcr.io/aaronkyriesenbach/jellarr:latest
```

## Docker

Images are published to `ghcr.io/aaronkyriesenbach/jellarr`. Use `latest` to
track releases, or pin a version tag (for example `0.1.0`) for reproducible
deployments.

The container runs once and exits. It reads `/config/config.yml` by default;
pass `--configFile` to use another path.

### Docker Compose

```yaml
services:
  jellarr:
    image: ghcr.io/aaronkyriesenbach/jellarr:latest
    container_name: jellarr
    environment:
      - JELLARR_API_KEY=${JELLARR_API_KEY}
      - TZ=Etc/UTC
    volumes:
      - ./config:/config:ro
    restart: 'no'
```

Run it with `docker compose run --rm jellarr`.

### Running on a schedule

Because the container exits after applying, schedule it with whatever you
already use: a host cron job or systemd timer running
`docker compose run --rm jellarr`, or a Kubernetes `CronJob`. Applying is
idempotent, so running more often than needed is harmless.

### Secrets

Jellarr reads the API key from the `JELLARR_API_KEY` environment variable. Pass
it with `-e`, `--env-file`, or your orchestrator's secret mechanism.

User passwords can be set inline (`password`) or read from a file
(`passwordFile`). Prefer `passwordFile` and mount the files into the container,
for example as Docker or Kubernetes secrets at `/run/secrets/`. Paths in
`passwordFile` are resolved inside the container.

### Exporting an existing configuration

```bash
docker run --rm \
  -e JELLARR_API_KEY=your_api_key \
  ghcr.io/aaronkyriesenbach/jellarr:latest \
  dump --baseUrl http://jellyfin:8096 > config.yml
```

The dump includes system settings, encoding options, libraries, branding, users
(without passwords), and plugin configurations. Edit the output before using it:
remove fields you don't want to manage, remove defaults, and add `password` or
`passwordFile` for each user. See [`dumped-example.yml`](./dumped-example.yml)
for sample output.

## Configuration

Jellarr reads a YAML file (default `config/config.yml`). `version`, `base_url`,
and `system` are required; every other section is optional, and only the fields
you set are modified. A complete example is in [`config.yml`](./config.yml).

### System

```yaml
system:
  enableMetrics: true # Prometheus metrics endpoint
  pluginRepositories:
    - name: 'Jellyfin Official'
      url: 'https://repo.jellyfin.org/releases/plugin/manifest.json'
      enabled: true
  trickplayOptions:
    enableHwAcceleration: true
    enableHwEncoding: true
```

### Encoding

```yaml
encoding:
  enableHardwareEncoding: true
  # none, amf, qsv, nvenc, v4l2m2m, vaapi, videotoolbox, rkmpp
  hardwareAccelerationType: 'vaapi'
  vaapiDevice: '/dev/dri/renderD128'
  qsvDevice: '/dev/dri/renderD128' # when using qsv
  hardwareDecodingCodecs: [h264, hevc, mpeg2video, vc1, vp8, vp9, av1]
  enableDecodingColorDepth10Hevc: true
  enableDecodingColorDepth10HevcRext: true
  enableDecodingColorDepth12HevcRext: true
  enableDecodingColorDepth10Vp9: true
  allowHevcEncoding: false
  allowAv1Encoding: false
```

### Libraries

```yaml
library:
  virtualFolders:
    - name: 'Movies'
      collectionType: 'movies'
      libraryOptions:
        pathInfos:
          - path: '/data/movies'
    - name: 'TV Shows'
      collectionType: 'tvshows'
      libraryOptions:
        pathInfos:
          - path: '/data/tv'
```

### Branding

```yaml
branding:
  loginDisclaimer: |
    Configured by
    <a href="https://github.com/aaronkyriesenbach/jellarr">Jellarr</a>
  customCss: |
    @import url("https://cdn.jsdelivr.net/npm/jellyskin@latest/dist/main.css");
  splashscreenEnabled: false
```

### Users

```yaml
users:
  - name: 'regular-user'
    passwordFile: '/run/secrets/viewer-password'
  - name: 'admin-user'
    passwordFile: '/run/secrets/admin-password'
    policy:
      isAdministrator: true
      loginAttemptsBeforeLockout: 3
```

Each user must have exactly one of `password` (plaintext, for development only)
or `passwordFile` (a file containing only the password; surrounding whitespace
is trimmed).

### Startup wizard

```yaml
system: {}
startup:
  completeStartupWizard: true
```

Marks the startup wizard as complete, which is useful for fully automated
deployments.

### Plugins

```yaml
plugins:
  - name: 'Playback Reporting'
  - name: 'Trakt'
    configuration:
      TraktUsers:
        - ExtraLogging: true
```

- Plugins are installed from the repositories in `system.pluginRepositories`.
- Names must match the repository entry exactly (case-sensitive).
- `configuration` accepts arbitrary plugin-specific key-value pairs. Only the
  fields you specify are updated.
- Configuration is applied after installation, so a newly installed plugin can
  be configured in the same run.

To discover a plugin's configuration keys, query the Jellyfin API:

```bash
curl -s -H "Authorization: MediaBrowser Token=\"$API_KEY\"" \
  "http://localhost:8096/Plugins" | jq '.[] | select(.Name == "Trakt")'

curl -s -H "Authorization: MediaBrowser Token=\"$API_KEY\"" \
  "http://localhost:8096/Plugins/{pluginId}/Configuration"
```

## Development

Requires [Bun](https://bun.sh) and Node.js 24.

```bash
bun install
bun run dev --configFile config.yml  # run from source
bun run build                         # bundle to bundle.cjs
bun run typecheck
bun run lint
bun run format  # prettier --write
bun run test  # not `bun test`
```

Source layout:

- `src/cli`: Commander entry point (`apply` and `dump`).
- `src/pipeline`: reads and validates the config, creates the API client, and
  runs each apply module.
- `src/apply`: one module per feature, split into a pure `calculate*Diff`
  function and an `apply*` function that calls the API.
- `src/mappers`, `src/types`: config-to-API mapping and Zod/OpenAPI types.

Run `bun run typegen` to regenerate `generated/schema.d.ts` from Jellyfin's
OpenAPI spec.

Pull requests are welcome. CI runs build, typecheck, lint, and tests on every
push.

## Nix (community-maintained)

A flake with a NixOS module lives in [`nix/`](./nix). It is not used or actively
maintained by the maintainer; issues and pull requests from Nix users are
welcome. It may lag behind the container image.

```nix
{
  inputs.jellarr.url = "github:aaronkyriesenbach/jellarr";

  outputs = { nixpkgs, jellarr, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [
        jellarr.nixosModules.default
        ({ config, ... }: {
          services.jellarr = {
            enable = true;
            user = "jellyfin";
            group = "jellyfin";
            environmentFile = config.sops.templates.jellarr-env.path;
            config = {
              base_url = "http://localhost:8096";
              system.enableMetrics = true;
            };
          };
        })
      ];
    };
  };
}
```

Run the CLI directly with
`JELLARR_API_KEY=... nix run github:aaronkyriesenbach/jellarr`.

The module takes the same configuration as the YAML file, as Nix attributes.
With [sops-nix](https://github.com/Mic92/sops-nix), provide the API key through
an environment file and user passwords through `passwordFile`:

```nix
{
  sops = {
    secrets = {
      jellarr-api-key.sopsFile = ./secrets/jellarr.env;
      admin-user-password.sopsFile = ./secrets/admin-user-password;
    };
    templates.jellarr-env = {
      content = ''
        JELLARR_API_KEY=${config.sops.placeholder.jellarr-api-key}
      '';
      owner = config.services.jellarr.user;
      group = config.services.jellarr.group;
    };
  };

  services.jellarr = {
    enable = true;
    environmentFile = config.sops.templates.jellarr-env.path;
    config = {
      base_url = "http://localhost:8096";
      users = [
        {
          name = "admin-user";
          passwordFile = config.sops.secrets.admin-user-password.path;
        }
      ];
    };
  };
}
```

### API key bootstrap

When Jellarr runs on the same host as Jellyfin, the module can insert an API key
into Jellyfin's database so you don't have to create one by hand:

```nix
services.jellarr = {
  enable = true;
  config.base_url = "http://localhost:8096";
  bootstrap = {
    enable = true;
    apiKeyFile = config.sops.secrets.jellarr-api-key.path;
    # Defaults:
    # apiKeyName = "jellarr";
    # jellyfinDataDir = "/var/lib/jellyfin";
    # jellyfinService = "jellyfin.service";
  };
};
```

The `jellarr-api-key-bootstrap` systemd service runs as root after Jellyfin
starts. If a key with the same name doesn't exist yet, it stops Jellyfin,
inserts the key into Jellyfin's SQLite database, and restarts Jellyfin. This is
the only place Jellarr touches Jellyfin's internals, and it only works when both
run on the same host. For a remote Jellyfin, create the key in the web UI and
pass it through `environmentFile`.

For development, the flake provides `nix build .#default`,
`nix build .#docker-image`, `nix flake check`, and `nix fmt`.

## License

[GNU AGPL-3.0](./LICENSE)
