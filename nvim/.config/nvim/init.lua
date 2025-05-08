-- Load core settings
require("core.options")  -- Load options
require("core.keymaps") -- Load keymaps

-- Load config via Lazy.nvim
require("config.lazy")

-- Set the default theme
vim.cmd("colorscheme carbonfox")

