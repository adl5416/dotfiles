return {
    {
        "mason-org/mason.nvim",
        version = "*",
        opts = {},
    },

    -- Mason-LSPConfig: Ensures installed LSPs integrate with nvim-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        version = "*",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },

    -- LSPConfig: Configures LSPs for Neovim
    {
        "neovim/nvim-lspconfig",
        version = "*",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("pyright", {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                        },
                    },
                },
            })
        end,
    }
}

