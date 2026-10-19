local M = {}

function M.setup(c)
  -- Snacks defaults hidden paths to NonText. Keep dotfiles readable in the
  -- Explorer while preserving the quieter color used for tree guides.
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = c.fg_soft })

  -- Snacks Explorer formats branch guides with SnacksPickerTree. Its default
  -- LineNr link is too prominent when repeated densely in the tree gutter.
  vim.api.nvim_set_hl(0, "SnacksPickerTree", { fg = c.tree_line })

  -- Snacks defaults untracked filenames to NonText. That role is intentionally
  -- very subdued here, so keep new files readable and let the `?` marker carry
  -- the untracked state.
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = c.fg_soft })

  -- The prompt icon is rendered in the input window's statuscolumn, whose
  -- default background comes from SignColumn rather than the float surface.
  vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = c.blue, bg = c.surface })
end

return M
