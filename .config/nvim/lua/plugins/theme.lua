local theme = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = {     -- :h background
                    dark = "mocha",
                },
                transparent_background = false, -- disables setting the background color.
                show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
                term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false,            -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15,          -- percentage of the shade to apply to the inactive window
                },
                no_italic = false,              -- Force no italic
                no_bold = false,                -- Force no bold
                no_underline = false,           -- Force no underline
                styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" },    -- Change the style of comments
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
        end
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },

    {
        "LunarVim/lunar.nvim"

    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            local time = os.date("%H:%M")
            local date = os.date("%a %d %b")
            local v = vim.version()
            local version = "v" .. v.major .. "." .. v.minor .. "." .. v.patch

            -- Set header
            dashboard.section.header.val = {
                "       _                        ",
                "       \\`*-.                    ",
                "        )  _`-.                 ",
                "       .  : `. .                ",
                "       : _   '  \\               ",
                "       ; *` _.   `*-._          ",
                "       `-.-'          `-.       ",
                "         ;       `       `.     ",
                "         :.       .        \\    ",
                "         . \\  .   :   .-'   .   ",
                "         '  `+.;  ;  '      :   ",
                "         :  '  |    ;       ;-. ",
                "         ; '   : :`-:     _.`* ;",
                "[bug] .*' /  .*' ; .*`- +'  `*' ",
                "      `*-*   `*-*  `*-*'        ",
                "░▒█▄░▒█░▒█▀▀▀░▒█▀▀▀█░▒█░░▒█░▀█▀░▒█▀▄▀█",
                "░▒█▒█▒█░▒█▀▀▀░▒█░░▒█░░▒█▒█░░▒█░░▒█▒█▒█",
                "░▒█░░▀█░▒█▄▄▄░▒█▄▄▄█░░░▀▄▀░░▄█▄░▒█░░▒█"

            }
            dashboard.section.header.opts.hl = "GruvboxBlue"
            dashboard.section.footer.opts.hl = "GruvboxBlue"

            dashboard.section.buttons.val = {
                dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "󰮗   Find file", ":cd $HOME | Telescope find_files<CR>"),
                dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
                dashboard.button("c", "   Configuration", ":e ~/.config/nvim/lua/user/config.lua<CR>"),
                dashboard.button("R", "󱘞   Ripgrep", ":Telescope live_grep<CR>"),
                dashboard.button("q", "󰗼   Quit", ":qa<CR>"),
            }

            function centerText(text, width)
                local totalPadding = width - #text
                local leftPadding = math.floor(totalPadding / 2)
                local rightPadding = totalPadding - leftPadding
                return string.rep(" ", leftPadding) .. text .. string.rep(" ", rightPadding)
            end

            local cuties = {
                "cats & catppuccin :3",
            }

            dashboard.section.footer.val = {
                centerText(cuties[math.random(1, #cuties)], 50),
                " ",
                centerText(date, 50),
                centerText(time, 50),
                centerText(version, 50),
            }

            -- Send config to alpha
            alpha.setup(dashboard.opts)

            -- Disable folding on alpha buffer
            vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
    },
}














return theme
