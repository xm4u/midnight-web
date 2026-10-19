local root = vim.fn.getcwd()
vim.opt.runtimepath:prepend(root)

local function check(condition, message)
  if not condition then
    error(message, 2)
  end
end

local function rgb(hex)
  check(type(hex) == "string" and hex:match("^#%x%x%x%x%x%x$"), "invalid HEX: " .. tostring(hex))
  return {
    tonumber(hex:sub(2, 3), 16) / 255,
    tonumber(hex:sub(4, 5), 16) / 255,
    tonumber(hex:sub(6, 7), 16) / 255,
  }
end

local function luminance(hex)
  local channels = rgb(hex)
  for index, value in ipairs(channels) do
    channels[index] = value <= 0.04045 and value / 12.92 or ((value + 0.055) / 1.055) ^ 2.4
  end
  return 0.2126 * channels[1] + 0.7152 * channels[2] + 0.0722 * channels[3]
end

local function contrast(first, second)
  local a, b = luminance(first), luminance(second)
  if a < b then
    a, b = b, a
  end
  return (a + 0.05) / (b + 0.05)
end

local palettes = require("midnight-web.palette")
local palette = palettes.classic
for name, expected in pairs({
  bg = "#080F1C",
  surface = "#101B2B",
  selection = "#233750",
  fg = "#CBD6E6",
  red = "#D97B87",
  blue = "#86B6E0",
  cyan = "#9CC2CF",
  green = "#A4C2A4",
  amber = "#D9B77E",
  lavender = "#B7A3D6",
  peach = "#DDA08A",
  periwinkle = "#9EAED1",
  muted = "#71849D",
}) do
  check(palette[name] == expected, "Classic palette color changed: " .. name)
end
for variant, colors in pairs(palettes) do
  for name, color in pairs(colors) do
    rgb(color)
    check(type(name) == "string", variant .. " palette entries must have string names")
  end
end

for _, path in ipairs(vim.fn.globpath(root, "**/*.lua", false, true)) do
  local chunk, err = loadfile(path)
  check(chunk ~= nil, "Lua parse error in " .. path .. ": " .. tostring(err))
end

local readable_roles = {
  "fg",
  "fg_soft",
  "muted",
  "red",
  "red_error",
  "blue",
  "cyan",
  "green",
  "amber",
  "lavender",
  "peach",
  "periwinkle",
}
for variant, colors in pairs(palettes) do
  for _, key in ipairs(readable_roles) do
    check(contrast(colors[key], colors.bg) >= 4.5, variant .. "." .. key .. " falls below 4.5:1 on the editor background")
    check(contrast(colors[key], colors.surface) >= 4.5, variant .. "." .. key .. " falls below 4.5:1 on panel surfaces")
  end
  check(contrast(colors.fg, colors.selection) >= 4.5, variant .. " selected text falls below 4.5:1")
  check(contrast(colors.tree_line, colors.surface) >= 3, variant .. " tree guides fall below 3:1")
  check(contrast(colors.tree_line, colors.surface) < 4.5, variant .. " tree guides should remain subdued")
  for fg, bg in pairs({
    red_error = "error_bg",
    amber = "warning_bg",
    blue = "info_bg",
    cyan = "info_bg",
    green = "success_bg",
  }) do
    check(contrast(colors[fg], colors[bg]) >= 4.5, variant .. "." .. fg .. " diagnostic contrast falls below 4.5:1")
  end
end
check(contrast(palette.blue, palette.surface) >= 4.5, "Snacks prompt icon falls below 4.5:1 against its surface")

local theme = require("midnight-web")
theme.setup({ variant = "classic" })
vim.cmd.colorscheme("midnight-web")
check(vim.g.colors_name == "midnight-web", "colorscheme did not set colors_name")
check(theme.get_variant() == "classic", "classic variant was not retained")

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = true })
end

for _, name in ipairs({
  "Normal",
  "NormalFloat",
  "FloatBorder",
  "CursorLine",
  "CursorLineNr",
  "CursorLineSign",
  "CursorLineFold",
  "SignColumn",
  "FoldColumn",
  "Visual",
  "Search",
  "Pmenu",
  "PmenuSel",
  "StatusLine",
  "WinSeparator",
  "DiffAdd",
  "DiagnosticError",
  "DiagnosticVirtualTextWarn",
  "DiagnosticFloatingHint",
  "DiagnosticUnderlineHint",
  "LspReferenceRead",
  "LspInlayHint",
  "@keyword.conditional",
  "@function.call",
  "@type.builtin",
  "@variable.parameter",
  "@markup.heading",
  "@tag.html",
  "@tag.css",
  "@attribute.css",
  "@type.css",
  "@constant.css",
  "@lsp.type.function",
  "@lsp.type.interface",
  "@lsp.type.parameter",
  "@lsp.mod.readonly",
  "@lsp.mod.deprecated",
  "LspCodeLens",
  "LspCodeLensSeparator",
  "LspReferenceTarget",
  "SnacksPickerTree",
  "SnacksPickerPrompt",
  "SnacksPickerGitStatusUntracked",
}) do
  check(next(highlight(name)) ~= nil, "expected highlight group missing: " .. name)
end

check(highlight("Normal").bg == tonumber(palette.bg:sub(2), 16), "Normal background does not match palette")
check(highlight("@function.call").link == "Function", "function calls should share the blue function role")
check(highlight("@keyword.conditional").link == "@keyword", "conditional keywords should use the keyword role")
check(highlight("@variable.parameter").fg == tonumber(palette.fg_soft:sub(2), 16), "parameters should use the soft text role")
check(highlight("@string").link == "String", "strings should use the sage String role")
check(highlight("String").fg == tonumber(palette.green:sub(2), 16), "String should use sage green")
check(highlight("@property").fg == tonumber(palette.periwinkle:sub(2), 16), "properties should use periwinkle")
check(highlight("@constant").fg == tonumber(palette.lavender:sub(2), 16), "constants should use lavender")
check(highlight("@attribute").fg == tonumber(palette.peach:sub(2), 16), "decorators should use peach")
check(highlight("@tag.html").fg == tonumber(palette.cyan:sub(2), 16), "HTML tag names should use grey-cyan")
check(highlight("@tag.css").fg == tonumber(palette.cyan:sub(2), 16), "CSS element selectors should use grey-cyan")
check(highlight("@attribute.css").fg == tonumber(palette.periwinkle:sub(2), 16), "CSS pseudo-selectors should use periwinkle")
check(highlight("@type.css").fg == tonumber(palette.periwinkle:sub(2), 16), "CSS class selectors should use periwinkle")
check(highlight("@constant.css").fg == tonumber(palette.lavender:sub(2), 16), "CSS id selectors should use lavender")
check(highlight("SnacksPickerTree").fg == tonumber(palette.tree_line:sub(2), 16), "Snacks tree guides should use the quieter guide color")
check(highlight("SnacksPickerPrompt").fg == tonumber(palette.blue:sub(2), 16), "Snacks prompt should use the function blue")
check(highlight("SnacksPickerPrompt").bg == tonumber(palette.surface:sub(2), 16), "Snacks prompt should blend into the float surface")
check(
  highlight("SnacksPickerGitStatusUntracked").fg == tonumber(palette.fg_soft:sub(2), 16),
  "untracked Snacks Explorer filenames should remain readable"
)

check(vim.hl.priorities.treesitter < vim.hl.priorities.semantic_tokens, "semantic tokens should layer above Tree-sitter")
check(highlight("@lsp.type.function").link == "@function", "LSP functions should reuse the Tree-sitter function role")
check(highlight("@lsp.type.method").link == "@function.method", "LSP methods should reuse the blue method role")
check(highlight("@lsp.type.enumMember").link == "@constant", "LSP enum members should reuse lavender constants")
check(highlight("@lsp.type.decorator").link == "@attribute", "LSP decorators should reuse peach annotations")
check(highlight("@lsp.type.parameter").link == "@variable.parameter", "LSP parameters should remain distinct from local variables")
check(highlight("@lsp.type.property").link == "@property", "LSP properties should reuse the periwinkle property role")

local ts_runtime = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
local site = vim.fn.stdpath("data") .. "/site"
if vim.uv.fs_stat(ts_runtime) then
  vim.opt.runtimepath:append(ts_runtime)
end
if vim.uv.fs_stat(site) then
  vim.opt.runtimepath:append(site)
end
if vim.treesitter.language.add("toml") then
  local ok, query = pcall(vim.treesitter.query.get, "toml", "highlights")
  if ok and query then
    check(vim.tbl_contains(query.captures, "type"), "TOML table headers should use the custom @type capture")
  end
end
check(vim.fn.filereadable(root .. "/queries/css/highlights.scm") == 1, "CSS unit/color query extension is missing")

for variant, colors in pairs(palettes) do
  theme.setup({ variant = variant })
  check(vim.g.colors_name == "midnight-web", variant .. " setup did not keep the colorscheme active")
  check(theme.get_variant() == variant, variant .. " variant was not retained")
  check(highlight("Normal").bg == tonumber(colors.bg:sub(2), 16), variant .. " background did not load")
  check(highlight("NormalFloat").bg == tonumber(colors.surface:sub(2), 16), variant .. " surface did not load")
  check(
    highlight("SnacksPickerGitStatusUntracked").fg == tonumber(colors.fg_soft:sub(2), 16),
    variant .. " untracked Snacks Explorer filenames should remain readable"
  )
  for _, group in ipairs({ "SignColumn", "FoldColumn", "CursorLineSign", "CursorLineFold", "WinSeparator" }) do
    check(
      highlight(group).bg == tonumber(colors.surface:sub(2), 16),
      variant .. " " .. group .. " should blend with the Snacks Explorer surface"
    )
  end
  check(highlight("Function").fg == tonumber(colors.blue:sub(2), 16), variant .. " function color changed")
  check(highlight("String").fg == tonumber(colors.green:sub(2), 16), variant .. " string color changed")
  check(highlight("@property").fg == tonumber(colors.periwinkle:sub(2), 16), variant .. " property color changed")
  check(
    vim.api.nvim_get_hl(0, { name = "@lsp.type.function", link = false }).fg == tonumber(colors.blue:sub(2), 16),
    variant .. " LSP function tokens diverged from Tree-sitter"
  )
  check(
    vim.api.nvim_get_hl(0, { name = "@lsp.type.property", link = false }).fg == tonumber(colors.periwinkle:sub(2), 16),
    variant .. " LSP property tokens diverged from Tree-sitter"
  )

  vim.api.nvim_set_hl(0, "MidnightWebReloadProbe", { fg = "#FFFFFF" })
  vim.cmd.colorscheme("midnight-web")
  check(next(highlight("MidnightWebReloadProbe")) == nil, variant .. " reload did not clear stale highlight groups")
  check(theme.get_variant() == variant, variant .. " selection was lost on colorscheme reload")
end

theme.setup({ variant = "classic" })
local invalid = pcall(theme.setup, { variant = "neon" })
check(not invalid and theme.get_variant() == "classic", "invalid variant should fail without changing Classic")

print("Midnight Web Classic, Deep, and Soft: all checks passed")
