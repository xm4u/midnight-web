# Midnight Web for Ghostty

This folder contains native Ghostty themes for the Midnight Web **Classic** and
**Deep** palettes:

- `Midnight Web Classic` — background `#080F1C`, selection `#233750`.
- `Midnight Web Deep` — background `#050A14`, selection `#1C2D44`.

## Install

From the repository root, choose a theme and copy it into Ghostty's user themes
directory. For example, to install Classic:

```sh
theme="Midnight Web Classic"
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes"
cp "extras/ghostty/$theme" \
  "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes/$theme"
```

Set the matching theme name in your Ghostty config:

```ini
theme = "Midnight Web Classic"
```

Replace `Classic` with `Deep` in both places to use the Deep variant.
