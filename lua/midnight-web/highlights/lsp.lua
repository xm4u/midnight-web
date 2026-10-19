local M = {}

local links = {
  ["@lsp.type.class"] = "@type",
  ["@lsp.type.decorator"] = "@attribute",
  ["@lsp.type.enum"] = "@type",
  ["@lsp.type.enumMember"] = "@constant",
  ["@lsp.type.event"] = "@property",
  ["@lsp.type.function"] = "@function",
  ["@lsp.type.interface"] = "@type",
  ["@lsp.type.keyword"] = "@keyword",
  ["@lsp.type.macro"] = "@function.macro",
  ["@lsp.type.method"] = "@function.method",
  ["@lsp.type.modifier"] = "@keyword.modifier",
  ["@lsp.type.namespace"] = "@module",
  ["@lsp.type.number"] = "@number",
  ["@lsp.type.operator"] = "@operator",
  ["@lsp.type.parameter"] = "@variable.parameter",
  ["@lsp.type.property"] = "@property",
  ["@lsp.type.regexp"] = "@string.regexp",
  ["@lsp.type.string"] = "@string",
  ["@lsp.type.struct"] = "@type",
  ["@lsp.type.type"] = "@type",
  ["@lsp.type.typeParameter"] = "@type",
  ["@lsp.type.variable"] = "@variable",

  ["@lsp.mod.readonly"] = "@constant",
  ["@lsp.mod.deprecated"] = "DiagnosticDeprecated",
}

function M.setup(c)
  for group, target in pairs(links) do
    vim.api.nvim_set_hl(0, group, { link = target })
  end

  local highlights = {
    ["@lsp.type.comment"] = { fg = c.muted, italic = true },
    ["@lsp.mod.abstract"] = { italic = true },
    ["@lsp.mod.async"] = { fg = c.blue, italic = true },
    ["@lsp.mod.modification"] = { underline = true },
    ["@lsp.mod.static"] = { italic = true },
    ["@lsp.typemod.function.async"] = { italic = true },
    ["@lsp.typemod.method.async"] = { italic = true },
    ["@lsp.typemod.function.deprecated"] = { strikethrough = true },
    ["@lsp.typemod.method.deprecated"] = { strikethrough = true },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end

  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.red_error })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = c.amber })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.blue })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = c.cyan })
  vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = c.green })

  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = c.red_error, bg = c.error_bg })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = c.amber, bg = c.warning_bg })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = c.blue, bg = c.info_bg })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = c.cyan, bg = c.info_bg })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { fg = c.green, bg = c.success_bg })

  vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = c.red_error })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = c.amber })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = c.blue })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = c.cyan })
  vim.api.nvim_set_hl(0, "DiagnosticSignOk", { fg = c.green })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.red_error })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = c.amber })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = c.cyan })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { undercurl = true, sp = c.green })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = c.red_error })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = c.amber })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = c.blue })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = c.cyan })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = c.green })
  vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = c.muted, italic = true })
  vim.api.nvim_set_hl(0, "DiagnosticDeprecated", { strikethrough = true })

  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = c.selection })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = c.selection })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = c.selection, underline = true })
  vim.api.nvim_set_hl(0, "LspReferenceTarget", { bg = c.selection, underline = true })
  vim.api.nvim_set_hl(0, "LspCodeLens", { fg = c.muted, italic = true })
  vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { fg = c.border })
  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = c.muted, bg = c.surface })
  vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = c.cyan, bold = true, underline = true })
end

return M
