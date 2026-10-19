-- Run in a Neovim session with a Rust or Go buffer open, Tree-sitter active,
-- and a semantic-token-capable LSP attached. This checks real semantic-token
-- extmarks, not only whether the corresponding highlight groups exist.
local api = vim.api
local buf = api.nvim_get_current_buf()
local theme = require("midnight-web")
local palette = require("midnight-web.palette")[theme.get_variant()]
local semantic_colors = {
  class = palette.cyan,
  comment = palette.muted,
  decorator = palette.peach,
  enum = palette.cyan,
  enumMember = palette.lavender,
  ["function"] = palette.blue,
  interface = palette.cyan,
  keyword = palette.red,
  macro = palette.peach,
  method = palette.blue,
  namespace = palette.cyan,
  number = palette.amber,
  operator = palette.fg_soft,
  parameter = palette.fg_soft,
  property = palette.periwinkle,
  string = palette.green,
  struct = palette.cyan,
  type = palette.cyan,
  typeParameter = palette.cyan,
  variable = palette.fg,
}

local function has_semantic_client()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
    if client.server_capabilities.semanticTokensProvider then
      return true
    end
  end
  return false
end

vim.wait(15000, has_semantic_client, 100)
assert(has_semantic_client(), "no semantic-token LSP attached to the current buffer")
vim.wait(2500)
assert(
  vim.treesitter.highlighter.active[buf] ~= nil,
  "Tree-sitter is not active in the current buffer"
)

local namespaces = api.nvim_get_namespaces()
local tokens_seen = 0
local file = api.nvim_buf_get_name(buf)
local filename = vim.fn.fnamemodify(file, ":t")

for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
  if client.server_capabilities.semanticTokensProvider then
    local namespace = namespaces["nvim.lsp.semantic_tokens:" .. client.id]
    if namespace then
      local marks = api.nvim_buf_get_extmarks(buf, namespace, 0, -1, { details = true })
      for _, mark in ipairs(marks) do
        local details = mark[4]
        local group = details.hl_group
        if type(group) == "string" then
          tokens_seen = tokens_seen + 1
          local token_type = group:match("^@lsp%.type%.([^.]+)")
          local expected = token_type and semantic_colors[token_type]
          local expected_priority = group:match("^@lsp%.typemod%.")
              and vim.hl.priorities.semantic_tokens + 2
            or group:match("^@lsp%.mod%.") and vim.hl.priorities.semantic_tokens + 1
            or vim.hl.priorities.semantic_tokens

          assert(
            details.priority == expected_priority,
            ("unexpected semantic-token priority for %s: %s"):format(group, tostring(details.priority))
          )

          if expected then
            local actual = api.nvim_get_hl(0, { name = group, link = false })
            assert(
              actual.fg == tonumber(expected:sub(2), 16),
              ("semantic token %s resolved to %s instead of %s"):format(
                group,
                actual.fg and string.format("#%06X", actual.fg) or "no foreground",
                expected
              )
            )
          end
        end
      end
      print(("PASS LSP %-14s %s tokens=%d"):format(client.name, filename, #marks))
    end
  end
end

assert(tokens_seen > 0, "the attached LSP returned no semantic-token extmarks")
print(("Checked live semantic tokens: %d marks in %s"):format(tokens_seen, filename))
