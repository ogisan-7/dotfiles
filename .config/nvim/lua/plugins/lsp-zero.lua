return {
    {
        "folke/neoconf.nvim",
        config = function()
        end
    },
    {
        "folke/lazydev.nvim",
        config = function()
            require("lazydev").setup({})
        end
    },

    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {},
    },

    {
        "lopi-py/luau-lsp.nvim"
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',

        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",

        },
        config = function()
            local cmp = require('cmp')
            local cmp_window = require "cmp.config.window"


            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ["<Tab>"] = cmp.mapping.select_next_item({
                        behavior = cmp.ConfirmBehavior.Insert,
                    }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },

                window = {
                    completion = cmp_window.bordered(),
                    documentation = cmp_window.bordered(),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    max_width = 0,
                    kind_icons = require("icons"),
                    source_names = {
                        nvim_lsp = "(LSP)",
                        emoji = "(Emoji)",
                        path = "(Path)",
                        calc = "(Calc)",
                        cmp_tabnine = "(Tabnine)",
                        vsnip = "(Snippet)",
                        luasnip = "(Snippet)",
                        buffer = "(Buffer)",
                        tmux = "(TMUX)",
                        copilot = "(Copilot)",
                        treesitter = "(TreeSitter)",
                    },
                    duplicates = {
                        buffer = 1,
                        path = 1,
                        nvim_lsp = 0,
                        luasnip = 1,
                    },
                    duplicates_default = 0,
                    format = function(entry, vim_item)
                        source_names = {
                            nvim_lsp = "(LSP)",
                            emoji = "(Emoji)",
                            path = "(Path)",
                            calc = "(Calc)",
                            cmp_tabnine = "(Tabnine)",
                            vsnip = "(Snippet)",
                            luasnip = "(Snippet)",
                            buffer = "(Buffer)",
                            tmux = "(TMUX)",
                            copilot = "(Copilot)",
                            treesitter = "(TreeSitter)",
                        }
                        local max_width = 0
                        -- if max_width ~= 0 and #vim_item.abbr > max_width then
                        --   vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. require("icons").ui.Ellipsis
                        -- end
                        vim_item.kind = require("icons").kind[vim_item.kind]

                        if entry.source.name == "copilot" then
                            vim_item.kind = require("icons").git.Octoface
                            vim_item.kind_hl_group = "CmpItemKindCopilot"
                        end

                        if entry.source.name == "cmp_tabnine" then
                            vim_item.kind = require("icons").misc.Robot
                            vim_item.kind_hl_group = "CmpItemKindTabnine"
                        end

                        if entry.source.name == "crates" then
                            vim_item.kind = require("icons").misc.Package
                            vim_item.kind_hl_group = "CmpItemKindCrate"
                        end

                        if entry.source.name == "lab.quick_data" then
                            vim_item.kind = require("icons").misc.CircuitBoard
                            vim_item.kind_hl_group = "CmpItemKindConstant"
                        end

                        if entry.source.name == "emoji" then
                            vim_item.kind = require("icons").misc.Smiley
                            vim_item.kind_hl_group = "CmpItemKindEmoji"
                        end
                        vim_item.menu = source_names[entry.source.name]
                        return vim_item
                    end,
                },
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart', },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },


        init = function()
            -- Reserve a space in the gutter
            -- This will avoid an annoying layout shift in the screen
            vim.opt.signcolumn = 'yes'
        end,
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>',
                        '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })

            require('mason-lspconfig').setup({
                automatic_installation = {},
                ensure_installed = {},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    ["luau_lsp"] = function()
                        require("luau-lsp").setup({

                            sourcemap = {
                                enabled = false,
                            },
                            platform = {
                                type = "roblox",
                            },
                            types = {
                                roblox_security_level = "PluginSecurity",
                            },
                            plugin = {
                                enabled = true,
                                port = 3667,
                            },
                            fflags = {
                                sync = true,               -- sync currently enabled fflags with roblox's published fflags
                                override = {
                                    LuauSolverV2 = "True", -- enable the new solver
                                },
                            },
                            server = {
                                settings = {
                                    -- https://github.com/folke/neoconf.nvim/blob/main/schemas/luau_lsp.json
                                    ["luau-lsp"] = {
                                        completion = {
                                            addParentheses = true,
                                            addTabstopAfterParentheses = true,
                                            autocompleteEnd = true,
                                            enabled = true,
                                            fillCallArguments = true,
                                            imports = {
                                                enabled = true,
                                            },
                                        }
                                    },
                                },
                                capabilites = lsp_defaults.capabilities
                            },

                        })
                    end

                }
            })
        end
    }
}
