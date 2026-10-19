local root = vim.fn.getcwd()
local install_dir = assert(vim.env.MIDNIGHT_WEB_TREESITTER_INSTALL_DIR, "set an isolated parser install dir")

vim.opt.runtimepath:prepend(root)

local ts = require("nvim-treesitter")
ts.setup({ install_dir = install_dir })

local installed = ts.install({ "css" }, { summary = true }):wait(300000)
assert(installed, "CSS parser install failed; inspect :TSLog")

require("midnight-web").setup({ variant = "classic" })
vim.cmd.colorscheme("midnight-web")
dofile(root .. "/tests/check_treesitter.lua")
