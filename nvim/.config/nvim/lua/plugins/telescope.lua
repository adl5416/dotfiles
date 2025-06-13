return {
    'nvim-telescope/telescope.nvim',
    version = "*",
    cmd = { "Telescope" }, -- Plugin loads only when you run :Telescope
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    },
    opts = { -- Add options here
        defaults = {
            mappings = {
                i = {  -- Insert mode mappings
                    ["<C-\\>"] = require("telescope.actions").select_vertical,  -- Open in vertical split
                    ["<C-|>"] = require("telescope.actions").select_vertical,  --- Open in vertical split
                    ["<C-_>"] = require("telescope.actions").select_horizontal, -- Open in horizontal split
                    ["<C-->"] = require("telescope.actions").select_horizontal, -- Open in horizontal split
                },
            }
        }
    }
}

