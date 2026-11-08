# Jellarr agent guide

Declarative Jellyfin configuration tool (TypeScript, Bun, Node 24 runtime).
Distributed as a container image; the Nix flake in `nix/` is
community-maintained and not actively used by the maintainer.

## Commands

- `bun install --frozen-lockfile`
- `bun run build`: bundle with esbuild to `bundle.cjs`
- `bun run typecheck`
- `bun run lint`
- `bun run format` (write) and `bun run format:check` (CI)
- `bun run test`: Vitest (not `bun test`, which is Bun's own runner)
- `bun run typegen`: regenerate `generated/schema.d.ts` from Jellyfin's OpenAPI
  spec

Run build, typecheck, lint, format:check, and test before committing.

## Conventions

- Import with the `@/` alias (`src/`) and `@generated/` alias (`generated/`),
  not relative paths.
- Prettier formatting: single quotes, semicolons, trailing commas, 100 columns,
  2 spaces (80 columns for YAML and Markdown). The organize-imports plugin sorts
  imports.
- Strict TypeScript. No `any`; ESLint enforces explicit types and return types.
- Each feature in `src/apply/` has a pure `calculate*Diff` function and a
  side-effecting `apply*` function. Keep them separate.
- Commit messages follow `<type>: <description>` (`feat`, `fix`, `refactor`,
  `test`, `docs`, `chore`), 80 characters at most. release-please builds the
  changelog from them.

## Releases

release-please opens a release PR on `master`. Merging it tags a release and
publishes the image through the shared workflows in
`aaronkyriesenbach/workflows`. `nix/package.nix` carries an
`x-release-please-version` marker so its version stays in sync.

## Nix

Changes to `nix/` are reviewed but cannot be built or tested by the maintainer.
Changing `bun.lock` changes the `outputHash` of `jellarr-node-modules` in
`nix/package.nix`; leave it for a Nix user to refresh (build with a fake hash
and copy the reported one).
