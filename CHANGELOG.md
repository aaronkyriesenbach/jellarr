# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1](https://github.com/aaronkyriesenbach/jellarr/compare/jellarr-v0.2.0...jellarr-v0.2.1) (2026-11-08)


### Bug Fixes

* read client version from package.json ([88c0a92](https://github.com/aaronkyriesenbach/jellarr/commit/88c0a922ef31b3ec29643f7f6dacb505f1e886f1))

## [0.2.0](https://github.com/aaronkyriesenbach/jellarr/compare/jellarr-v0.1.0...jellarr-v0.2.0) (2026-11-08)


### Features

* add comment policy automation via uncomment tool ([392a12f](https://github.com/aaronkyriesenbach/jellarr/commit/392a12feba1f3c6442e93f20a86e9240f43a3c6a))
* add comprehensive integration tests for user policy support ([ef9403f](https://github.com/aaronkyriesenbach/jellarr/commit/ef9403fa749d1dc4094688ed962045ce24f711e9))
* add experimental dump command to export Jellyfin config ([99d6e05](https://github.com/aaronkyriesenbach/jellarr/commit/99d6e057b40a645ebccc6fa25c0fc57e447a4eae))
* add experimental dump command to export Jellyfin config ([bcaeaca](https://github.com/aaronkyriesenbach/jellarr/commit/bcaeacaf69c71ba9f62bcbce8e25d6d883eef0df))
* add plugin configuration support ([c328c1d](https://github.com/aaronkyriesenbach/jellarr/commit/c328c1d7843ca1f51d793d1cf9f6816bc86f7a1c))
* add plugin installation support ([3fa3e7e](https://github.com/aaronkyriesenbach/jellarr/commit/3fa3e7e1c586962a8730505e08265ddbd48e76b9))
* add startup.completeStartupWizard config option ([9332e69](https://github.com/aaronkyriesenbach/jellarr/commit/9332e692d563d521233732ae2d8770038421a2dd))
* add startup.completeStartupWizard config option ([8f8df1d](https://github.com/aaronkyriesenbach/jellarr/commit/8f8df1d092623f2cec959fd433e9e8931ff1d41b)), closes [#23](https://github.com/aaronkyriesenbach/jellarr/issues/23)
* add stylisticTypeChecked preset with targeted overrides ([5d55e40](https://github.com/aaronkyriesenbach/jellarr/commit/5d55e409ef359f1abd7692c29c81ef38119cf027))
* add support for user policy configuration (src only) - manually integration tested ([4b1cf56](https://github.com/aaronkyriesenbach/jellarr/commit/4b1cf566255762032fe64b064ca38c015b23125c))
* add typed Nix module configuration with schema validation ([832cfc5](https://github.com/aaronkyriesenbach/jellarr/commit/832cfc55a65628f4eaa84c2a987b9e73af1087a7))
* add typed Nix module configuration with schema validation ([e6af22d](https://github.com/aaronkyriesenbach/jellarr/commit/e6af22d88d54620509c66a9cd887fb121769ae03))
* add user management support with secure password handling ([08617a6](https://github.com/aaronkyriesenbach/jellarr/commit/08617a6047b1ac2c4e15b702cd311772e6b7c488))
* add user management support with secure password handling ([013e91b](https://github.com/aaronkyriesenbach/jellarr/commit/013e91b8eace5e3c0babd8c9a3df82f5d14d7dac)), closes [#12](https://github.com/aaronkyriesenbach/jellarr/issues/12) [#13](https://github.com/aaronkyriesenbach/jellarr/issues/13)
* **eslint:** add naming convention rules ([099e601](https://github.com/aaronkyriesenbach/jellarr/commit/099e601a3180d986369ab100f8ddb06928046f35))
* expand integration tests and add Python formatting improvements ([e8d3db1](https://github.com/aaronkyriesenbach/jellarr/commit/e8d3db17f1b9c647fe199760e4bf97d867668b45))
* expand integration tests and add Python formatting improvements ([2d27e91](https://github.com/aaronkyriesenbach/jellarr/commit/2d27e91d1215a2b984991bfee0a885e349cc28b2)), closes [#15](https://github.com/aaronkyriesenbach/jellarr/issues/15)
* implement maximum typedef strictness for explicit type annotations ([1eb2e34](https://github.com/aaronkyriesenbach/jellarr/commit/1eb2e343b946ee920ccd7be0922073e2b36dc592))
* split treefmt into format and lint modules ([d4570ee](https://github.com/aaronkyriesenbach/jellarr/commit/d4570ee2bb20786dbedfb12e7419a8a05a6031a8))
* split treefmt into format and lint modules ([b72bce1](https://github.com/aaronkyriesenbach/jellarr/commit/b72bce14c90d4a98b15d475909c7109cb304125f))


### Bug Fixes

* authenticate with the Authorization header ([317f7be](https://github.com/aaronkyriesenbach/jellarr/commit/317f7be9d4a758f25b8180feb41fae12530a53a1))
* fetcherVersion ([80a97b1](https://github.com/aaronkyriesenbach/jellarr/commit/80a97b1c73ea7564a7cc0b398a7c786250218ee7))
* only dump encoding fields that exist in config ([8d81e12](https://github.com/aaronkyriesenbach/jellarr/commit/8d81e1203cd122565791fdf20173d99f1236dc5d))
* only dump encoding fields that exist in config ([916836a](https://github.com/aaronkyriesenbach/jellarr/commit/916836a351ae35c87f5ff804aacab39981f5f9b0))
* update fetcher Version ([de530bc](https://github.com/aaronkyriesenbach/jellarr/commit/de530bc0117eb4018598a67245e748623a6ce6dc))

## [0.1.0] - 2025-01-24

### Added

#### Plugin Management

- **New Feature**: Full support for declarative plugin installation and
  configuration
- **Configuration Fields**:
  - `plugins[].name`: Plugin name (must match repository exactly,
    case-sensitive)
  - `plugins[].configuration`: Arbitrary key-value pairs for plugin-specific
    settings
- **API Integration**: Uses Jellyfin's `POST /Packages/Installed/{name}` for
  installation and `/Plugins/{pluginId}/Configuration` for configuration
- **Idempotent**: Skips already-installed plugins; only updates specified
  configuration fields while preserving unspecified settings
- **Workflow**: Newly installed plugins can be configured in the same run

#### Export Existing Configuration (Experimental)

- **New Feature**: `dump` command to export current Jellyfin server
  configuration as YAML
- **Usage**: `jellarr dump --baseUrl http://localhost:8096 > config.yml`
- **Exports**: System settings, encoding options, libraries, branding, users
  (without passwords), and plugin configurations
- **Use Case**: Bootstrap a new Jellarr config from an existing Jellyfin server
- **Note**: User passwords cannot be exported and must be added manually

#### API Key Bootstrap (NixOS)

- **New Feature**: Automatic API key provisioning for NixOS deployments
- **Problem Solved**: Eliminates manual API key creation for "from scratch"
  setups and disaster recovery scenarios
- **Configuration Options**:
  - `bootstrap.enable`: Toggle bootstrap on/off
  - `bootstrap.apiKeyFile`: Path to file containing the API key (works with
    sops-nix)
  - `bootstrap.apiKeyName`: Name for the key (defaults to "jellarr")
  - `bootstrap.jellyfinDataDir`: Path to Jellyfin data directory
  - `bootstrap.jellyfinService`: Systemd service name for Jellyfin
- **How It Works**: `jellarr-api-key-bootstrap` systemd oneshot service inserts
  the API key directly into Jellyfin's SQLite database before Jellarr runs
- **Idempotent**: Uses "insert if not present" SQL to prevent duplicate entries
- **Limitation**: Requires Jellarr and Jellyfin to be on the same host

#### Typed NixOS Module

- **New Feature**: Strongly-typed Nix module configuration with schema
  validation
- **Benefits**:
  - Catches configuration errors at Nix evaluation time
  - Better IDE support with proper NixOS option types
  - Validates all fields match expected types and constraints
- **Implementation**: Nix-native type definitions mirroring TypeScript Zod
  schemas

### Infrastructure

- **Cachix Integration**: Added Cachix caching for Nix builds in CI pipeline

### Changed

#### NixOS Module Improvements

- **Config Format**: Changed config type to `pkgs.formats.yaml` for better Nix
  integration and type coercion

#### Internal Architecture Refactor

- **Major Refactor**: Complete rewrite of apply/diff logic using `json-diff-ts`
  library
- **Problem Solved**: Eliminated ~1000 lines of redundant "deepEqual" comparison
  logic scattered across apply modules
- **New Pattern**: Fluent `ChangeSetBuilder` API for consistent diff handling
  - `atomize()` / `unatomize()`: Control change granularity
  - `withoutRemoves()` / `withoutUpdates()`: Filter change types
  - `withKey()`: Target specific configuration keys
- **Benefits**:
  - Consistent pattern across all apply modules
  - Cleaner separation between mappers and apply logic
  - More maintainable codebase
- **Modules Updated**: branding, encoding-options, library, system, users,
  plugins

### Configuration Example

```yaml
version: 1
base_url: "http://localhost:8096"
system:
    enableMetrics: true
    pluginRepositories:
        - name: "Jellyfin Official"
          url: "https://repo.jellyfin.org/releases/plugin/manifest.json"
          enabled: true
plugins:
    - name: "Trakt"
      configuration:
          TraktUsers:
              - ExtraLogging: true
    - name: "Playback Reporting"
```

### Breaking Changes

- **Potential Breaking**: This release is a significant internal rewrite. While
  the configuration format remains fully backward compatible, the underlying
  diff/apply logic has been completely reimplemented. Please test thoroughly
  before upgrading production systems.

---

## [0.0.3] - 2025-11-30

### Added

#### Startup Wizard Configuration

- **New Feature**: Support for completing Jellyfin's startup wizard via config
- **Configuration Fields**:
  - `startup.completeStartupWizard`: When `true`, marks the startup wizard as
    complete
- **API Integration**: Uses Jellyfin's `POST /Startup/Complete` endpoint
- **Use Case**: Useful for automated/declarative deployments where you want to
  skip the interactive startup wizard

#### User Management

- **New Feature**: Full support for declarative user creation and management
- **Configuration Fields**:
  - `users[].name`: Username for the account
  - `users[].password`: Plaintext password (development only)
  - `users[].passwordFile`: Path to file containing password (production
    recommended)
- **Security**: Supports secure password handling via file references for
  sops-nix integration
- **Idempotent**: Only creates users that don't already exist

#### User Policy Configuration

- **New Feature**: Configure user permissions and policies declaratively
- **Configuration Fields**:
  - `users[].policy.isAdministrator`: Grant admin privileges
  - `users[].policy.loginAttemptsBeforeLockout`: Set lockout threshold
- **API Integration**: Uses Jellyfin's `/Users/{userId}/Policy` endpoint
- **Comprehensive Testing**: Unit tests for types, API, mappers, and apply
  modules

### Infrastructure

#### CI Pipeline

- **New Feature**: Automated CI pipeline for quality validation
- **Checks**: Build, typecheck, ESLint, unit tests, Nix package build, flake
  check
- **Integration**: Runs on push to main and pull requests

#### NixOS VM Integration Tests

- **New Feature**: VM-based integration testing framework
- **Coverage**: Full end-to-end testing with real Jellyfin server

#### Code Quality Improvements

- **ESLint Enhancements**:
  - Added `stylisticTypeChecked` preset with targeted overrides
  - Added naming convention rules for consistent code style
  - Implemented maximum typedef strictness for explicit type annotations
  - Added comment policy automation via uncomment tool
- **Treefmt Refactor**: Split into separate format and lint modules for
  independent control

### Configuration Example

```yaml
version: 1
base_url: "http://localhost:8096"
system: {}
users:
    - name: "admin-user"
      passwordFile: "/run/secrets/admin-password"
      policy:
          isAdministrator: true
          loginAttemptsBeforeLockout: 3
    - name: "viewer-user"
      passwordFile: "/run/secrets/viewer-password"
startup:
    completeStartupWizard: true
```

### Breaking Changes

- None - All features are additive with full backward compatibility

---

## [0.0.2] - 2025-11-17

### Added

#### Branding Configuration Support

- **New Feature**: Full support for Jellyfin branding configuration options
- **Configuration Fields**:
  - `loginDisclaimer`: Custom text displayed on the login page (supports HTML)
  - `customCss`: Custom CSS to modify Jellyfin's appearance (supports @import
    rules)
  - `splashscreenEnabled`: Toggle the Jellyfin splash screen on/off
- **API Integration**: Uses Jellyfin's `/System/Configuration/Branding` endpoint
- **Idempotent Operations**: Only applies changes when configuration differs
  from server state
- **Null/Empty String Handling**: Properly handles server responses with null
  values

#### Documentation Improvements

- **Updated README**: Added complete branding configuration section with
  examples
- **Configuration Examples**:
  - Basic branding setup
  - HTML-enabled login disclaimers with hyperlinks
  - CSS theming with external stylesheets (Jellyskin theme example)
- **API Documentation**: Documented branding endpoints and expected schemas

### Technical Implementation

#### Architecture Adherence

- **Calculate/Apply Pattern**: Follows established pattern for clean separation
  of concerns
  - `calculateBrandingOptionsDiff()`: Pure calculation logic, returns schema or
    undefined
  - `applyBrandingOptions()`: Side effects only, handles API calls
- **Type Safety**: Full TypeScript integration with Zod validation
- **Naming Conventions**: Consistent with established `XyzAbcConfigType`
  patterns

#### Files Added/Modified

- `src/types/config/branding-options.ts` - Configuration type definitions
- `src/types/schema/branding-options.ts` - Server API schema types
- `src/mappers/branding-options.ts` - Config-to-schema transformation
- `src/apply/branding-options.ts` - Application logic with calculate/apply
  pattern
- `src/api/jellyfin_client.ts` - API client methods for branding endpoints
- `src/pipeline/index.ts` - Pipeline integration for branding configuration
- `tests/**/*branding-options.spec.ts` - Comprehensive test suites

### Configuration Example

```yaml
version: 1
base_url: "https://jellyfin.example.com"
system:
# ... system config
branding:
    loginDisclaimer: |
        Welcome! Configured by <a href="https://github.com/venkyr77/jellarr">Jellarr</a>
    customCss: |
        @import url("https://cdn.jsdelivr.net/npm/jellyskin@latest/dist/main.css");
    splashscreenEnabled: false
```

### Breaking Changes

- None - This is an additive feature with full backward compatibility

---

## [0.0.1] - Initial Release

### Added

- Initial implementation of declarative Jellyfin configuration management
- Support for system configuration (metrics, plugin repositories, trickplay
  options)
- Support for encoding configuration (hardware encoding settings)
- Support for library configuration (content scanning and metadata options)
- TypeScript implementation with strict type safety
- Comprehensive test suite with integration testing
- Nix flakes support for reproducible builds
- Docker integration with distroless images
- CLI interface with YAML configuration files

### Technical Features

- **Calculate/Apply Pattern**: Clean separation between configuration
  calculation and application
- **Idempotent Operations**: Only modifies explicitly specified configuration
  fields
- **API Integration**: Uses Jellyfin's OpenAPI specification with generated
  types
- **Validation**: Zod-based configuration validation with detailed error
  messages
- **Authentication**: Secure API key-based authentication with environment
  variables

### Supported Configuration Areas

- **System Configuration**: Server metrics, plugin repositories, trickplay
  options
- **Encoding Configuration**: Hardware encoding, codec preferences, quality
  settings
- **Library Configuration**: Content scanning intervals, metadata providers,
  subtitle preferences

[0.1.0]: https://github.com/venkyr77/jellarr/compare/v0.0.3...v0.1.0
[0.0.3]: https://github.com/venkyr77/jellarr/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/venkyr77/jellarr/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/venkyr77/jellarr/releases/tag/v0.0.1
