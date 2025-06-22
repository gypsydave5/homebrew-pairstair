# Homebrew Pairstair

Homebrew tap for installing [pairstair](https://github.com/gypsydave5/pairstair).

## Installation

```
brew install gypsydave5/pairstair/pairstair
```

## GitHub Actions Workflow

This repository contains a GitHub Actions workflow that can update the formula when new releases of pairstair are published:

**Update Formula on New Release**: Updates the formula with new versions when manually triggered

### Manual Update

You can trigger an update by going to the Actions tab, selecting "Update Formula on New Release", and providing the version number (without the 'v' prefix).

### Permissions

For this workflow to function properly, you need to enable Actions write permissions:

1. Go to your repository's Settings
2. Navigate to Actions > General
3. Under "Workflow permissions", select "Read and write permissions"
4. Click "Save"

This allows the GitHub Actions to commit and push changes to the repository.
