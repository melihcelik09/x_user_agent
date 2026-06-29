# Releasing

This package publishes from GitHub Actions using version tags.

## Version format

- Regular release: `1.2.3`
- Build metadata release: `1.2.3+4`
- Git tag format: `v<version>`

Examples:

- `1.0.0` -> `v1.0.0`
- `1.0.0+1` -> `v1.0.0+1`

## pub.dev setup

In the package admin page on `pub.dev`, enable automated publishing and use:

- Repository: `melihcelik09/x_user_agent`
- Tag pattern: `v{{version}}`

## Release flow

1. Update `version:` in `pubspec.yaml`.
2. Update `CHANGELOG.md`.
3. Commit your changes.
4. Run `bash tool/release_tag.sh --push`.

The script reads `pubspec.yaml`, creates the matching `v<version>` tag, and pushes it.

## Why the workflow uses `v*`

The GitHub Actions workflow triggers on `v*` so both plain versions and `+` build metadata tags are picked up.
`pub.dev` still validates that the pushed tag exactly matches `v{{version}}`.
