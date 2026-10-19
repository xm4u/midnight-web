local config = require("midnight-web.config")

local M = {}

function M.setup(opts)
  config.setup(opts)

  if vim.g.colors_name == "midnight-web" then
    M.load()
  end
end

function M.load()
  local variant = vim.g.midnight_web_variant or config.variant or "classic"
  local palette = require("midnight-web.palette")[variant]
  assert(palette, "Midnight Web variant must be 'classic', 'deep', or 'soft'")

  -- Clear old definitions so re-sourcing the colorscheme is deterministic.
  vim.cmd("highlight clear")
  vim.o.background = "dark"
  vim.o.termguicolors = true

  require("midnight-web.highlights.editor").setup(palette)
  require("midnight-web.highlights.syntax").setup(palette)
  require("midnight-web.highlights.treesitter").setup(palette)
  require("midnight-web.highlights.lsp").setup(palette)
  require("midnight-web.integrations.snacks").setup(palette)

  vim.g.colors_name = "midnight-web"
end

function M.get_variant()
  return vim.g.midnight_web_variant or config.variant or "classic"
end

return M
