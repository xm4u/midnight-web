# Midnight Web for tmux

This directory contains the Midnight Web **Classic** adaptation for tmux. Its
status line is inspired by [Catppuccin for tmux](https://github.com/catppuccin/tmux),
but it is standalone and uses the exact semantic palette from
`lua/midnight-web/palette.lua`.

The theme provides:

- a rounded session badge and window tabs;
- distinct active, activity, and bell states;
- matching pane, popup, menu, message, and copy-mode colors; and
- the current pane path plus clock on the right.

## Install

Source `midnight-web-classic.tmux` from your tmux configuration after the
general tmux options:

```tmux
source-file "/path/to/midnight-web/extras/tmux/midnight-web-classic.tmux"
```

Reload tmux with `tmux source-file ~/.tmux.conf`, or restart the server if the
status layout was already configured by another theme.

The rounded separators use the `` and `` glyphs, so a Nerd Font is
recommended. Replace those glyphs with plain spaces if your terminal does not
include them.
