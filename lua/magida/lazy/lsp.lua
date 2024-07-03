return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())
        -- local on_attach = require("plugins.configs.lspconfig").on_attach
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "omnisharp"
            },
            handlers = {
                function(server_name) -- default handler (optional)

                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["yamlls"] = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.yamlls.setup {
                        capabilities = capabilities,
                    }
                end,
                ["svelte"] = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.svelte.setup{
                        capabilities = capabilities,
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

                ["omnisharp"] = function()
                    local server_opts = {
                        enable_editorconfig_support = true,
                        enable_roslyn_analyzers     = false,
                        enable_import_completion    = true,
                        sdk_include_prereleases     = false,
                        handlers                    = {
                            ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
                            ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
                            ["textDocument/references"] = require('omnisharp_extended').references_handler,
                            ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
                        }
                    }


                    local capabilities_omnisharp = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
                    capabilities.textDocument.completion.completionItem.snippetSupport = true
                    capabilities.textDocument.foldingRange = {
                        dynamicRegistration = true,
                        lineFoldingOnly = true,
                    }

                    server_opts = vim.tbl_deep_extend("force", server_opts, {
                        on_attach = on_attach,
                        capabilities = capabilities_omnisharp,
                        flags = {
                            debounce_text_changes = 150,
                        }
                    })

                    local lspconfig = require("lspconfig")
                    lspconfig.omnisharp.setup(server_opts)
                end
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
