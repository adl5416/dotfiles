return {
  "tpope/vim-fugitive",
  version = "*",
  cmd = { "Git", "G" }, -- Load only when running Git commands
  keys = {
    -- Git Status & Commit
    { "<leader>gc", "<cmd>Git commit -v -a<CR>", desc = "Git Commit All" },
    -- Git Push, Pull & Fetch
    { "<leader>gp", "<cmd>Git pull<CR>", desc = "Git Pull" },
    { "<leader>gP", "<cmd>Git push<CR>", desc = "Git Push" },
    { "<leader>gf", "<cmd>Git fetch<CR>", desc = "Git Fetch All" },
    -- Git Diff & Logs
    { "<leader>gd", "<cmd>Git diff<CR>", desc = "Git Diff" },
    { "<leader>gl", "<cmd>Git log --graph --oneline --abbrev-commit --date=relative --max-count=10<CR>", desc = "Git Log Graph" },
    { "<leader>gL", "<cmd>Git log --stat --oneline --abbrev-commit --date=relative --max-count=10<CR>",desc = "Git Log" },
    -- Git Reset & Checkout
    { "<leader>gr", "<cmd>Git restore .<CR>", desc = "Git Restore All" },
    { "<leader>gR", "<cmd>Git restore --staged .<CR>", desc = "Git Unstage All" },
  },
}

