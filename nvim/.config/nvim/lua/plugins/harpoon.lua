return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    vim.keymap.set("n", "<leader>ma", function() harpoon:list():append() end, { desc = "Add File to Harpoon" })
    vim.keymap.set("n", "<leader>ml", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open Harpoon Menu" })
    vim.keymap.set("n", "<leader>m1", function() harpoon:list():select(1) end, { desc = "Go to Harpoon File 1" })
    vim.keymap.set("n", "<leader>m2", function() harpoon:list():select(2) end, { desc = "Go to Harpoon File 2" })
    vim.keymap.set("n", "<leader>m3", function() harpoon:list():select(3) end, { desc = "Go to Harpoon File 3" })
    vim.keymap.set("n", "<leader>m4", function() harpoon:list():select(4) end, { desc = "Go to Harpoon File 4" })
    vim.keymap.set("n", "<leader>m5", function() harpoon:list():select(5) end, { desc = "Go to Harpoon File 5" })
    vim.keymap.set("n", "<leader>m6", function() harpoon:list():select(6) end, { desc = "Go to Harpoon File 6" })
    vim.keymap.set("n", "<leader>m7", function() harpoon:list():select(7) end, { desc = "Go to Harpoon File 7" })
    vim.keymap.set("n", "<leader>m8", function() harpoon:list():select(8) end, { desc = "Go to Harpoon File 8" })
    vim.keymap.set("n", "<leader>mr", function() harpoon:list():remove() end, { desc = "Remove File from Harpoon" })
  end
}

