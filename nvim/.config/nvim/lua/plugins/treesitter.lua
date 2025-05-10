return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  config = function()
    require("nvim-treesitter.configs").setup({
    ensure_installed = {
                          "bash",
                          "c",
                          "diff",
                          "html",
                          "javascript",
                          "jsdoc",
                          "json",
                          "jsonc",
                          "lua",
                          "luadoc",
                          "luap",
                          "markdown",
                          "markdown_inline",
                          "printf",
                          "python",
                          "query",
                          "regex",
                          "toml",
                          "tsx",
                          "typescript",
                          "vim",
                          "vimdoc",
                          "xml",
                          "yaml",
                        },
      sync_install = false, -- Install parsers asynchronously
      highlight = { enable = true }, -- Enable syntax highlighting
    })
  end,
}
