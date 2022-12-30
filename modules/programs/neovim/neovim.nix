{ config, lib, pkgs, ...}:

{
	programs.neovim = {
		enable = true;
		extraConfig = ''
			luafile /home/rafa/.nixos/modules/programs/neovim/settings.lua
			luafile /home/rafa/.nixos/modules/programs/neovim/treesitter.lua
			lua require'nvim-tree'.setup {}

			" vimtex configuration
			let g:vimtex_view_method = 'zathura'
		'';
		plugins = with pkgs.vimPlugins; [

			# file tree
			nvim-web-devicons
			nvim-tree-lua

			# lsp
			nvim-lspconfig
			nvim-compe

			# languages
			vimtex
			vim-nix

			# highlighting
			nvim-treesitter.withAllGrammars

			# other
			indentLine
		];
	};
}
