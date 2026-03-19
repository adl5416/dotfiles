return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = { enabled = true }, -- Highlight the current file in the tree
        use_libuv_file_watcher = true, -- Update tree when files change
      },
      window = {
          mappings = {
              ["l"] = "toggle_node",  -- Use 'l' to open a file or enter a directory
              ["h"] = "close_node",    -- Use 'h' to close an open directory node
              ["H"] = "",              -- Remove H from toggling hidden
              ["."] = "toggle_hidden", -- Map . to toggle hidden

        },
        width = 30, -- Set the width of the file explorer
      },
    })
    -- Keybinding to toggle Neo-Tree
    vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
  end,
}

