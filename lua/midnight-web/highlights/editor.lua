local M = {}

function M.setup(c)
  local highlights = {
    Normal = { fg = c.fg, bg = c.bg },
    NormalNC = { fg = c.fg, bg = c.bg },
    NormalFloat = { fg = c.fg, bg = c.surface },
    FloatBorder = { fg = c.border, bg = c.surface },
    FloatTitle = { fg = c.cyan, bg = c.surface, bold = true },
    FloatFooter = { fg = c.muted, bg = c.surface },

    Cursor = { fg = c.bg, bg = c.fg },
    CursorLine = { bg = c.line },
    CursorColumn = { bg = c.line },
    CursorLineNr = { fg = c.cyan, bg = c.line, bold = true },
    LineNr = { fg = c.muted, bg = c.bg },
    LineNrAbove = { fg = c.muted, bg = c.bg },
    LineNrBelow = { fg = c.muted, bg = c.bg },
    -- The editor's reserved gutter sits directly beside Snacks Explorer. Keep
    -- its sign/fold cells and split seam on the shared panel surface so the
    -- Explorer edge does not look like a strip of editor background.
    SignColumn = { bg = c.surface },
    CursorLineSign = { bg = c.surface },
    ColorColumn = { bg = c.surface },
    FoldColumn = { fg = c.muted, bg = c.surface },
    CursorLineFold = { fg = c.muted, bg = c.surface },
    Folded = { fg = c.fg_soft, bg = c.surface },
    EndOfBuffer = { fg = c.bg, bg = c.bg },

    Visual = { fg = c.fg, bg = c.selection },
    VisualNOS = { fg = c.fg, bg = c.selection },
    Search = { fg = c.fg, bg = c.diff_change, bold = true },
    CurSearch = { fg = c.bg, bg = c.blue, bold = true },
    IncSearch = { fg = c.bg, bg = c.amber, bold = true },
    Substitute = { fg = c.bg, bg = c.red_error, bold = true },
    MatchParen = { fg = c.cyan, bg = c.selection, bold = true },

    Pmenu = { fg = c.fg, bg = c.surface },
    PmenuSel = { fg = c.fg, bg = c.selection, bold = true },
    PmenuSbar = { bg = c.surface_alt },
    PmenuThumb = { bg = c.border },
    PmenuKind = { fg = c.cyan, bg = c.surface },
    PmenuKindSel = { fg = c.cyan, bg = c.selection, bold = true },
    PmenuExtra = { fg = c.muted, bg = c.surface },
    PmenuExtraSel = { fg = c.fg_soft, bg = c.selection },
    PmenuMatch = { fg = c.blue, bg = c.surface, bold = true },
    PmenuMatchSel = { fg = c.blue, bg = c.selection, bold = true },
    WildMenu = { fg = c.bg, bg = c.cyan, bold = true },

    StatusLine = { fg = c.fg, bg = c.surface },
    StatusLineNC = { fg = c.muted, bg = c.bg },
    TabLine = { fg = c.fg_soft, bg = c.surface },
    TabLineSel = { fg = c.fg, bg = c.bg, bold = true },
    TabLineFill = { fg = c.muted, bg = c.bg },
    WinSeparator = { fg = c.border, bg = c.surface },
    VertSplit = { fg = c.border, bg = c.bg },
    WinBar = { fg = c.fg, bg = c.bg },
    WinBarNC = { fg = c.muted, bg = c.bg },
    MsgSeparator = { fg = c.border, bg = c.surface },

    Directory = { fg = c.blue },
    Title = { fg = c.blue, bold = true },
    MoreMsg = { fg = c.cyan },
    ModeMsg = { fg = c.fg_soft },
    Question = { fg = c.cyan },
    WarningMsg = { fg = c.amber },
    ErrorMsg = { fg = c.red_error, bold = true },
    NonText = { fg = c.border },
    SpecialKey = { fg = c.muted },
    Whitespace = { fg = c.border },
    Conceal = { fg = c.muted },
    QuickFixLine = { fg = c.fg, bg = c.selection },

    DiffAdd = { fg = c.green, bg = c.diff_add },
    DiffChange = { fg = c.blue, bg = c.diff_change },
    DiffDelete = { fg = c.red_error, bg = c.diff_delete },
    DiffText = { fg = c.fg, bg = c.selection, bold = true },
    DiffTextAdd = { fg = c.green, bg = c.diff_add, bold = true },
    SnippetTabstop = { fg = c.fg, bg = c.selection },
    SnippetTabstopActive = { fg = c.cyan, bg = c.selection, bold = true },

    Added = { fg = c.green },
    Changed = { fg = c.blue },
    Removed = { fg = c.red_error },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

return M
