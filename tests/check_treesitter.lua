local root = vim.fn.getcwd()
local isolated_install_dir = vim.env.MIDNIGHT_WEB_TREESITTER_INSTALL_DIR
if isolated_install_dir and isolated_install_dir ~= "" then
  vim.opt.runtimepath:prepend(isolated_install_dir)
end
vim.opt.runtimepath:prepend(root)

local data = vim.fn.stdpath("data")
local treesitter = data .. "/lazy/nvim-treesitter"
for _, path in ipairs({ treesitter, treesitter .. "/runtime", data .. "/site" }) do
  if vim.uv.fs_stat(path) then
    vim.opt.runtimepath:append(path)
  end
end

local filetype_script = treesitter .. "/plugin/filetypes.lua"
if vim.fn.filereadable(filetype_script) == 1 then
  dofile(filetype_script)
end

vim.treesitter.language.register("javascript", { "jsx", "javascriptreact" })
vim.treesitter.language.register("json", "jsonc")
vim.treesitter.language.register("tsx", { "typescriptreact", "typescript.tsx" })
vim.treesitter.language.register("yaml", "yml")

local variant = vim.g.midnight_web_variant or "classic"
require("midnight-web").setup({ variant = variant })
vim.cmd.colorscheme("midnight-web")

local cases = {
  { file = "config.yaml", ft = "yaml", lang = "yaml", expect = { "property", "string", "boolean", "constant.builtin", "label" } },
  { file = "config.yml", ft = "yaml", lang = "yaml", expect = { "property", "string", "boolean", "label" } },
  { file = "data.json", ft = "json", lang = "json", expect = { "property", "string", "number", "boolean", "constant.builtin" } },
  { file = "settings.jsonc", ft = "jsonc", lang = "json", expect = { "property", "string", "comment", "boolean", "constant.builtin" } },
  { file = "config.toml", ft = "toml", lang = "toml", expect = { "property", "type", "string", "number", "boolean" } },
  { file = "typescript.ts", ft = "typescript", lang = "typescript", expect = { "keyword", "function", "function.call", "type", "variable.parameter" } },
  { file = "javascript.js", ft = "javascript", lang = "javascript", expect = { "keyword", "function", "function.call", "string", "variable.parameter" } },
  {
    file = "tsx.tsx",
    ft = "typescriptreact",
    lang = "tsx",
    expect = { "tag", "tag.builtin", "tag.attribute", "function", "variable.parameter" },
    roles = { tag = "blue", ["tag.builtin"] = "cyan", ["tag.attribute"] = "periwinkle" },
  },
  {
    file = "app.jsx",
    ft = "jsx",
    lang = "javascript",
    expect = { "tag", "tag.builtin", "tag.attribute", "function", "variable.parameter" },
    roles = { tag = "blue", ["tag.builtin"] = "cyan", ["tag.attribute"] = "periwinkle" },
  },
  { file = "c.c", ft = "c", lang = "c", expect = { "keyword.directive", "function.macro", "type", "constant", "function.call" } },
  {
    file = "index.html",
    ft = "html",
    lang = "html",
    expect = { "tag", "tag.attribute", "tag.delimiter", "string", "comment" },
    roles = { tag = "cyan", ["tag.attribute"] = "periwinkle" },
  },
  { file = "python.py", ft = "python", lang = "python", expect = { "attribute", "function", "variable.parameter", "type", "string", "boolean" } },
  { file = "notes.md", ft = "markdown", lang = "markdown", expect = { "markup.heading.1", "markup.raw.block", "markup.list.checked" } },
  { file = "rust.rs", ft = "rust", lang = "rust", expect = { "function.macro", "attribute", "constant", "variable.parameter", "type" } },
  { file = "go.go", ft = "go", lang = "go", expect = { "function", "function.method", "property", "variable.parameter", "type.builtin" } },
  {
    file = "styles.css",
    ft = "css",
    lang = "css",
    expect = { "property", "type", "constant", "number", "keyword.directive", "tag", "attribute", "tag.attribute", "function", "variable" },
    roles = {
      type = "periwinkle",
      constant = "lavender",
      tag = "cyan",
      attribute = "periwinkle",
      ["tag.attribute"] = "periwinkle",
    },
  },
}

local palette = require("midnight-web.palette")[variant]
local role_colors = {
  keyword = palette.red,
  ["keyword.conditional"] = palette.red,
  ["function"] = palette.blue,
  ["function.call"] = palette.blue,
  ["function.method"] = palette.blue,
  type = palette.cyan,
  ["type.builtin"] = palette.cyan,
  string = palette.green,
  number = palette.amber,
  boolean = palette.amber,
  constant = palette.lavender,
  ["constant.builtin"] = palette.lavender,
  property = palette.periwinkle,
  attribute = palette.peach,
  ["function.macro"] = palette.peach,
  ["keyword.directive"] = palette.cyan,
  ["keyword.import"] = palette.red,
}

local skipped = {}
local parsed = 0

for _, case in ipairs(cases) do
  local path = root .. "/tests/fixtures/treesitter/" .. case.file
  local loaded, load_error = vim.treesitter.language.add(case.lang)
  if not loaded then
    local source_path = treesitter .. "/runtime/queries/" .. case.lang .. "/highlights.scm"
    local source_found = vim.fn.filereadable(source_path) == 1
    if source_found then
      local source = table.concat(vim.fn.readfile(source_path), "\n")
      for _, expected in ipairs(case.expect) do
        if not (case.lang == "css" and expected == "number") then
          assert(source:find("@" .. expected, 1, true), ("%s upstream query lacks @%s"):format(case.lang, expected))
        end
      end
      if case.lang == "css" then
        local extension = table.concat(vim.fn.readfile(root .. "/queries/css/highlights.scm"), "\n")
        assert(extension:find("(unit) @number", 1, true), "CSS units are not mapped to @number")
        assert(extension:find("(color_value) @constant", 1, true), "CSS color literals are not mapped to @constant")
        assert(extension:find("priority 101", 1, true), "CSS semantic overrides need to layer over upstream @string")
      end
      print(("SOURCE-ONLY %-12s upstream query inspected; parser unavailable"):format(case.lang))
    end
    local status = source_found and "source inspected; parser unavailable" or "query source and parser unavailable"
    skipped[#skipped + 1] = case.lang .. " (" .. status .. ": " .. tostring(load_error) .. ")"
  else
    local query = vim.treesitter.query.get(case.lang, "highlights")
    local captures = {}
    for _, capture in ipairs(query.captures) do
      captures[capture] = true
    end

    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(buf, path)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(path))
    vim.bo[buf].filetype = case.ft

    local parser = vim.treesitter.get_parser(buf, case.lang)
    local tree = parser:parse()[1]
    assert(not tree:root():has_error(), ("%s has Tree-sitter parse errors"):format(case.file))
    local seen = {}
    local css_units, css_colors = false, false
    for id, node, metadata in query:iter_captures(tree:root(), buf, 0, -1) do
      local capture = query.captures[id]
      seen[capture] = (seen[capture] or 0) + 1
      if case.lang == "toml" and capture == "type" then
        assert(tonumber(metadata.priority) == 105, "TOML table headings must outrank the upstream bare-key property capture")
      elseif case.lang == "css" and node:type() == "unit" and capture == "number" then
        assert(tonumber(metadata.priority) == 101, "CSS units must outrank the upstream string capture")
        css_units = true
      elseif case.lang == "css" and node:type() == "color_value" and capture == "constant" then
        assert(tonumber(metadata.priority) == 101, "CSS colors must outrank the upstream string capture")
        css_colors = true
      end
    end

    if case.lang == "css" then
      assert(css_units, "CSS sample did not exercise the unit-to-number extension")
      assert(css_colors, "CSS sample did not exercise the color-to-constant extension")
    end

    for _, expected in ipairs(case.expect) do
      assert(captures[expected], ("%s query lacks @%s capture"):format(case.lang, expected))
      assert(seen[expected], ("%s example did not exercise @%s"):format(case.file, expected))
    end

    for capture in pairs(seen) do
      if capture ~= "none" and capture ~= "spell" and capture ~= "nospell" and capture ~= "conceal" and not capture:match("^_") then
        local group = "@" .. capture .. "." .. case.lang
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        assert(next(hl) ~= nil, ("captured token %s in %s has no resolved highlight"):format(group, case.file))
        local color_name = case.roles and case.roles[capture]
        local expected_color = (color_name and palette[color_name]) or role_colors[capture]
        if expected_color then
          assert(hl.fg == tonumber(expected_color:sub(2), 16), ("%s in %s resolved to the wrong semantic color"):format(group, case.file))
        end
      end
    end

    local ok, err = pcall(vim.treesitter.start, buf, case.lang)
    assert(ok, ("failed to start Tree-sitter for %s: %s"):format(case.file, tostring(err)))
    parsed = parsed + 1
    print(("PASS %-18s lang=%-12s actual captures=%d"):format(case.file, case.lang, vim.tbl_count(seen)))
  end
end

local inline_available, inline_error = vim.treesitter.language.add("markdown_inline")
if inline_available then
  local query = vim.treesitter.query.get("markdown_inline", "highlights")
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "**bold** *italic* ~~removed~~ [guide](https://example.test/docs) `inline code`",
  })
  local parser = vim.treesitter.get_parser(buf, "markdown_inline")
  local tree = parser:parse()[1]
  local seen = {}
  for id in query:iter_captures(tree:root(), buf, 0, -1) do
    local capture = query.captures[id]
    seen[capture] = (seen[capture] or 0) + 1
  end
  for _, capture in ipairs({ "markup.strong", "markup.italic", "markup.strikethrough", "markup.link.label", "markup.link.url", "markup.raw" }) do
    assert(seen[capture], ("markdown_inline example did not exercise @%s"):format(capture))
  end
  assert(pcall(vim.treesitter.start, buf, "markdown_inline"), "failed to start markdown_inline highlighter")
  parsed = parsed + 1
  print(("PASS %-18s lang=%-12s actual captures=%d"):format("markdown inline", "markdown_inline", vim.tbl_count(seen)))
else
  skipped[#skipped + 1] = "markdown_inline (parser unavailable: " .. tostring(inline_error) .. ")"
end

print(("Tree-sitter parser fixtures parsed: %d/%d"):format(parsed, #cases + 1))
if #skipped > 0 then
  print("Not parsed (no local parser binary): " .. table.concat(skipped, "; "))
end
