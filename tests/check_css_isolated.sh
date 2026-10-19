#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/midnight-web-css.XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mason_bin=${MASON_BIN:-"$HOME/.local/share/nvim/mason/bin"}
if [ -d "$mason_bin" ]; then
  PATH="$mason_bin:$PATH"
  export PATH
fi

cd "$root"
MIDNIGHT_WEB_TREESITTER_INSTALL_DIR="$tmp/site" \
XDG_CACHE_HOME="$tmp/cache" \
nvim --headless -u NONE \
  --cmd 'lua local p=vim.fn.stdpath("data").."/lazy/nvim-treesitter"; vim.opt.runtimepath:append({p,p.."/runtime"})' \
  -l tests/check_css_isolated.lua
