return {
    -- Mason: LSP Installer
    {
        "williamboman/mason.nvim",
        version = "*",
        config = function()
            require("mason").setup()
        end
    },

    -- Mason-LSPConfig: Ensures installed LSPs integrate with nvim-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        version = "*",
        dependencies = { "williamboman/mason.nvim" },
    },

    -- LSPConfig: Configures LSPs for Neovim
    {
        "neovim/nvim-lspconfig",
        version = "*",
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

