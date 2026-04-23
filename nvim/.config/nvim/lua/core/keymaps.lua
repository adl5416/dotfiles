-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Tab / Shift-Tab to indent/dedent
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Dedent line" })
-- Keep lines highlighted in visual mode after indenting
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Dedent selection" })
-- Remove previous keybinds for Tab
vim.keymap.set("n", ">>", "<Nop>")
vim.keymap.set("n", "<<", "<Nop>")

-- LSP
-- Go to definition
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
