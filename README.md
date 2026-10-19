# Midnight Web

Midnight Web is a Lua colorscheme plugin for Neovim. It includes three dark
variants (Classic, Deep, and Soft) and Midnight Web Light. Classic is the default.
It has no third-party runtime dependencies.

## Install

### lazy.nvim

```lua
{
  "xm4u/midnight-web",
  lazy = false,
  priority = 1000,
  config = function()
    require("midnight-web").setup({ variant = "classic" })
    vim.cmd.colorscheme("midnight-web")
  end,
}
```

Replace `classic` with `deep`, `soft`, or `light` to choose another variant.
In LazyVim, the colorscheme can also be set through the usual `colorscheme`
option after installing the plugin.

### Native package directory

Clone the repository into a directory on Neovim's runtime path, for example:

```sh
git clone https://github.com/xm4u/midnight-web \
  "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/colors/start/midnight-web"
```

Then add `vim.cmd.colorscheme("midnight-web")` to your Neovim configuration.

## Configure

Classic loads by default:

```lua
vim.cmd.colorscheme("midnight-web")
```

Choose a variant before loading the colorscheme:

```lua
require("midnight-web").setup({ variant = "deep" })
vim.cmd.colorscheme("midnight-web")
```

Calling `setup()` while Midnight Web is active switches the current session.
Reloading `:colorscheme midnight-web` reapplies the selected variant. Supported
values are `classic`, `deep`, `soft`, and `light`.

To use Midnight Web Light:

```lua
require("midnight-web").setup({ variant = "light" })
vim.cmd.colorscheme("midnight-web")
```

Light sets Neovim's `background` to `light`; the dark variants set it to `dark`.

## Variants

| Variant | Background | Surface | Selection | Notes |
| --- | --- | --- | --- | --- |
| Classic | `#080F1C` | `#101B2B` | `#233750` | Default palette |
| Deep | `#050A14` | `#0C1626` | `#1C2D44` | Darker surfaces; Classic's syntax colors |
| Soft | `#0A1320` | `#121D2D` | `#263950` | Lifted surfaces and softer accents |
| Light | `#F5F7FB` | `#FFFFFF` | `#D9E5F2` | Cool daylight and muted chromatic accents |

The shared semantic map uses rose for keywords, blue for functions, grey-cyan
for types, sage for strings, amber for numbers, lavender for constants, peach
for annotations, and periwinkle for properties. Palette values live in
`lua/midnight-web/palette.lua`.

Ghostty is also supported; see the [Ghostty theme README](extras/ghostty/README.md)
for its theme and installation instructions.

tmux is also supported; see the [tmux theme README](extras/tmux/README.md) for
the Catppuccin-inspired Classic status line and installation instructions.

Light uses `#EAF0F7` for the active line and `#D8E0EB` for borders, with the
following text and syntax colors:

| Role | Color |
| --- | --- |
| Text and variables | `#243247` |
| Comments and secondary text | `#5A6B81` |
| Keywords and control flow | `#B73E54` |
| Functions and methods | `#2864A0` |
| Types and interfaces | `#287486` |
| Strings | `#3A7858` |
| Numbers | `#94601B` |
| Constants and enum members | `#7953A2` |
| Decorators and annotations | `#A8523C` |
| Properties and attributes | `#536BA5` |

## Integrations

The colorscheme defines standard Vim highlight groups, Tree-sitter captures,
and LSP semantic-token groups. It also includes query extensions for CSS
dimensions and color literals, and TOML table headers. Tree-sitter parsers and
LSP servers remain the user's responsibility.

Snacks.nvim is optional. When present, its Explorer tree guides and prompt use
the corresponding Midnight Web colors. The colorscheme does not configure or
install Snacks.nvim.

## Tests

Run the unit and highlight checks from the repository root:

```sh
nvim --headless -u NONE --cmd 'set runtimepath^=.' -l tests/run.lua
```

To exercise installed Tree-sitter parsers against the fixtures in
`tests/fixtures/treesitter/`:

```sh
nvim --headless -u NONE --cmd 'set runtimepath^=.' -l tests/check_treesitter.lua
```

Add `--cmd 'let g:midnight_web_variant="light"'` to check Light instead of Classic.

CSS parser validation can be run in an isolated temporary directory with
`sh tests/check_css_isolated.sh`. It requires nvim-treesitter and its Tree-sitter
CLI to be available to Neovim; the CSS parser is not installed into the normal
parser directory by this test.

`tests/check_lsp_runtime.lua` is an optional live check. Run it in a buffer with
Tree-sitter active and a Rust or Go LSP client that provides semantic tokens.

## License

MIT. See [LICENSE](LICENSE).
