-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- LSP
-- Go to definition
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
