return {

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "org" },


                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'org' }, -- This line is needed
                },
            }
        end
    },


}
