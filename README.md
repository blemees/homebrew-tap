# blemees Homebrew tap

Tap repository for the [blemees](https://github.com/blemees) suite.

## Add the tap

```sh
brew tap blemees/tap
```

## Available formulas

| Formula | What it installs | Service? |
|---|---|---|
| `blemees-agent` | The headless agent daemon (`blemees-agentd`) and its control CLI (`blemees-agentctl`) | Yes — `brew services start blemees-agent` |
| `blemees-peer` | The peer mesh daemon (`blemees-peerd`) and the stdio MCP sidecar (`blemees-peer-mcp`) | Yes — `brew services start blemees-peer` |
| `blemees-tui` | The interactive multi-session TUI (`blemees`). Pulls in `blemees-agent` as a Python dep | No (interactive) |

## Install

```sh
# Daemons
brew install blemees/tap/blemees-agent
brew install blemees/tap/blemees-peer

# Foreground TUI
brew install blemees/tap/blemees-tui

# Run the daemons under brew services
brew services start blemees-agent
brew services start blemees-peer
```

## Updates

Each upstream repo (`blemees-agent`, `blemees-peer`, `blemees-tui`) has a
`bump-tap.yml` GitHub Action that pushes a commit to this tap on every
release tag, updating the corresponding formula's `url` and `sha256`.
No manual action is needed once a release is cut.

To re-sync the tap to an existing tag (e.g. after editing a formula
manually), trigger the `Bump Homebrew tap` workflow in the relevant
upstream repo via `workflow_dispatch`.

## License

MIT.
