# Midnight Web Classic

Midnight Web uses **coral keywords**, *cool blue functions*, and grey-cyan types
on a deep, blue-black canvas. See the [palette guide](https://example.test/palette)
for semantic roles and readable contrast.

## Semantic accents

- [x] Keep ordinary variables neutral
- [ ] Add color to every token just because we can

> A subdued comment should remain easy to read in long documentation sessions.

| Token | Role | Tone |
| --- | --- | --- |
| `@keyword` | control flow | coral |
| `@function.call` | calls | soft blue |
| `@property` | object keys | periwinkle |

```lua
local preview = { variant = "classic", enabled = true }
vim.cmd.colorscheme("midnight-web")
```

Inline code stays calm: `vim.treesitter.query.get("typescript", "highlights")`.
