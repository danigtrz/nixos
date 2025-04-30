{ pkgs, config, ... }:

{
	programs.vscode = {
		enable = true;
		profiles.default.extensions = with pkgs.vscode-extensions; [
		 	# nix
		 	bbenoist.nix

		 	# python
		 	ms-python.python
		 	ms-python.vscode-pylance
		 	ms-toolsai.jupyter

		 	# c
		 	ms-vscode.cpptools-extension-pack

		 	# latex
		 	james-yu.latex-workshop

		 	# ai
		 	github.copilot
		 	github.copilot-chat

		 	# vim
		 	vscodevim.vim

		 	# theme
		 	catppuccin.catppuccin-vsc
		 	catppuccin.catppuccin-vsc-icons
		];
	};
}
