local M = {
  variant = "classic",
}

local variants = {
  classic = true,
  deep = true,
  soft = true,
}

function M.setup(opts)
  opts = opts or {}
  assert(type(opts) == "table", "midnight-web.setup expects an options table")

  local variant = opts.variant or M.variant
  assert(variants[variant], "Midnight Web variant must be 'classic', 'deep', or 'soft'")

  M.variant = variant
  vim.g.midnight_web_variant = variant
end

return M
