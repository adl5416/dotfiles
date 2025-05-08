return {
    -- Mason: LSP Installer
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    -- Mason-LSPConfig: Ensures installed LSPs integrate with nvim-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "clangd", "pyright", "rust_analyzer", "gopls", "ts_ls", "lua_ls", "jdtls",
                    "html", "cssls", "jsonls", "yamlls",
                    "dockerls", "bashls", "terraformls",
                    "intelephense", "kotlin_language_server", "solargraph"
                }
            }
        end
    },

    -- LSPConfig: Configures LSPs for Neovim
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")

            -- Setup LSPs
            local servers = {
                "clangd", "pyright", "rust_analyzer", "gopls", "ts_ls", "lua_ls", "jdtls",
                "html", "cssls", "jsonls", "yamlls",
                "dockerls", "bashls", "terraformls",
                "intelephense", "kotlin_language_server", "solargraph"
            }

            for _, server in ipairs(servers) do
                lspconfig[server].setup {}
            end
        end
    }
}

