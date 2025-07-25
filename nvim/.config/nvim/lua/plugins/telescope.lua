return {
    'nvim-telescope/telescope.nvim',
    version = "*",
    cmd = { "Telescope" }, -- Plugin loads only when you run :Telescope
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep hidden=true<cr>", desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
        { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    },
}

