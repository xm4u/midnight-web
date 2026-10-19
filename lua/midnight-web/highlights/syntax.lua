local M = {}

function M.setup(c)
  local highlights = {
    Comment = { fg = c.muted, italic = true },
    Constant = { fg = c.lavender },
    String = { fg = c.green },
    Character = { fg = c.green },
    Number = { fg = c.amber },
    Boolean = { fg = c.amber },
    Float = { fg = c.amber },

    Identifier = { fg = c.fg },
    Function = { fg = c.blue },
    Statement = { fg = c.red },
    Conditional = { fg = c.red },
    Repeat = { fg = c.red },
    Label = { fg = c.cyan },
    Operator = { fg = c.fg_soft },
    Keyword = { fg = c.red },
    Exception = { fg = c.red },

    PreProc = { fg = c.cyan },
    Include = { fg = c.cyan },
    Define = { fg = c.cyan },
    Macro = { fg = c.peach },
    PreCondit = { fg = c.cyan },
    Type = { fg = c.cyan },
    StorageClass = { fg = c.red },
    Structure = { fg = c.cyan },
    Typedef = { fg = c.cyan },

    Special = { fg = c.cyan },
    SpecialChar = { fg = c.cyan },
    Tag = { fg = c.cyan },
    Delimiter = { fg = c.muted },
    SpecialComment = { fg = c.muted, italic = true },
    Debug = { fg = c.amber },
    Underlined = { fg = c.blue, underline = true },
    Ignore = { fg = c.muted },
    Todo = { fg = c.amber, bold = true },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

return M
