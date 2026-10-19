local M = {}

local links = {
  ["@variable"] = "Identifier",
  ["@variable.builtin"] = "Special",
  ["@variable.parameter"] = "Identifier",
  ["@variable.parameter.builtin"] = "Special",
  ["@variable.member"] = "@property",

  ["@constant"] = "Constant",
  ["@constant.builtin"] = "Constant",
  ["@constant.macro"] = "Constant",
  ["@module"] = "@type",
  ["@module.builtin"] = "@type.builtin",
  ["@label"] = "Label",

  ["@string"] = "String",
  ["@string.documentation"] = "@string",
  ["@string.regexp"] = "@string",
  ["@string.escape"] = "@character.special",
  ["@string.special"] = "@string",
  ["@string.special.symbol"] = "@constant",
  ["@string.special.path"] = "@string",
  ["@string.special.url"] = "@markup.link.url",
  ["@character"] = "Character",
  ["@character.special"] = "SpecialChar",
  ["@boolean"] = "Boolean",
  ["@number"] = "Number",
  ["@number.float"] = "Float",

  ["@type"] = "Type",
  ["@type.builtin"] = "Type",
  ["@type.definition"] = "Type",
  ["@attribute"] = "Special",
  ["@attribute.builtin"] = "Special",

  ["@function"] = "Function",
  ["@function.builtin"] = "Function",
  ["@function.call"] = "Function",
  ["@function.macro"] = "Macro",
  ["@function.method"] = "Function",
  ["@function.method.call"] = "Function",
  ["@constructor"] = "@type",
  ["@operator"] = "Operator",

  ["@keyword"] = "Keyword",
  ["@keyword.coroutine"] = "@keyword",
  ["@keyword.function"] = "@keyword",
  ["@keyword.operator"] = "@keyword",
  ["@keyword.import"] = "@keyword",
  ["@keyword.type"] = "@type",
  ["@keyword.modifier"] = "@keyword",
  ["@keyword.repeat"] = "@keyword",
  ["@keyword.return"] = "@keyword",
  ["@keyword.debug"] = "@keyword",
  ["@keyword.exception"] = "@keyword",
  ["@keyword.conditional"] = "@keyword",
  ["@keyword.conditional.ternary"] = "@operator",
  ["@keyword.directive"] = "PreProc",
  ["@keyword.directive.define"] = "Define",

  ["@punctuation.delimiter"] = "Delimiter",
  ["@punctuation.bracket"] = "Delimiter",
  ["@punctuation.special"] = "Delimiter",
  ["@comment"] = "Comment",
  ["@comment.documentation"] = "Comment",
  ["@comment.error"] = "DiagnosticError",
  ["@comment.warning"] = "DiagnosticWarn",
  ["@comment.todo"] = "Todo",
  ["@comment.note"] = "DiagnosticInfo",

  ["@markup.strong"] = "Statement",
  ["@markup.italic"] = "Comment",
  ["@markup.strikethrough"] = "Comment",
  ["@markup.underline"] = "Underlined",
  ["@markup.heading"] = "Title",
  ["@markup.heading.1"] = "Title",
  ["@markup.heading.2"] = "Title",
  ["@markup.heading.3"] = "Title",
  ["@markup.heading.4"] = "Title",
  ["@markup.heading.5"] = "Title",
  ["@markup.heading.6"] = "Title",
  ["@markup.quote"] = "Comment",
  ["@markup.math"] = "@number",
  ["@markup.link"] = "Underlined",
  ["@markup.link.label"] = "@property",
  ["@markup.link.url"] = "Underlined",
  ["@markup.list"] = "@comment",
  ["@markup.list.checked"] = "DiagnosticOk",
  ["@markup.list.unchecked"] = "@comment",

  ["@diff.plus"] = "DiffAdd",
  ["@diff.minus"] = "DiffDelete",
  ["@diff.delta"] = "DiffChange",
  ["@tag.attribute"] = "@property",
  ["@tag.delimiter"] = "Delimiter",
}

function M.setup(c)
  for group, target in pairs(links) do
    vim.api.nvim_set_hl(0, group, { link = target })
  end

  vim.api.nvim_set_hl(0, "@variable.builtin", { fg = c.cyan })
  vim.api.nvim_set_hl(0, "@variable.parameter", { fg = c.fg_soft })
  vim.api.nvim_set_hl(0, "@variable.parameter.builtin", { fg = c.cyan })
  vim.api.nvim_set_hl(0, "@constant", { fg = c.lavender })
  vim.api.nvim_set_hl(0, "@constant.builtin", { fg = c.lavender })
  vim.api.nvim_set_hl(0, "@constant.macro", { fg = c.lavender })
  vim.api.nvim_set_hl(0, "@property", { fg = c.periwinkle })
  vim.api.nvim_set_hl(0, "@attribute", { fg = c.peach })
  vim.api.nvim_set_hl(0, "@attribute.builtin", { fg = c.peach })
  vim.api.nvim_set_hl(0, "@tag", { fg = c.blue })
  vim.api.nvim_set_hl(0, "@tag.builtin", { fg = c.cyan })

  -- HTML tags and CSS selectors have different roles than JSX component tags.
  vim.api.nvim_set_hl(0, "@tag.html", { fg = c.cyan })
  vim.api.nvim_set_hl(0, "@tag.css", { fg = c.cyan })
  vim.api.nvim_set_hl(0, "@attribute.css", { fg = c.periwinkle })
  vim.api.nvim_set_hl(0, "@type.css", { fg = c.periwinkle })
  vim.api.nvim_set_hl(0, "@constant.css", { fg = c.lavender })
  vim.api.nvim_set_hl(0, "@label", { fg = c.lavender })

  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = c.muted })
  vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = c.muted })
  vim.api.nvim_set_hl(0, "@punctuation.special", { fg = c.muted })
  vim.api.nvim_set_hl(0, "@markup.raw", { fg = c.fg_soft })
  vim.api.nvim_set_hl(0, "@markup.raw.block", { fg = c.fg_soft })
  vim.api.nvim_set_hl(0, "@markup.heading", { fg = c.blue, bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.1", { fg = c.blue, bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.2", { fg = c.cyan, bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.3", { fg = c.lavender, bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.4", { fg = c.periwinkle })
  vim.api.nvim_set_hl(0, "@markup.heading.5", { fg = c.fg_soft })
  vim.api.nvim_set_hl(0, "@markup.heading.6", { fg = c.fg_soft, italic = true })
  vim.api.nvim_set_hl(0, "@markup.strong", { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "@markup.italic", { fg = c.fg_soft, italic = true })
  vim.api.nvim_set_hl(0, "@markup.strikethrough", { fg = c.fg_soft, strikethrough = true })
end

return M
