require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
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
    },
})

vim.cmd.colorscheme "catppuccin"
