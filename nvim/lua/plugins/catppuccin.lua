return {
	"catppuccin/nvim",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "latte",
			transparent_background = false,
			show_end_of_buffer = true,
			term_colors = false,
			dim_inactive = {
				enabled = false,
			},
			no_italic = false,
			no_bold = false,
			no_underline = false,
			integrations = {
				treesitter = true,
			},
		})
	end
}
