{ pkgs, ... }:

{
	home.sessionVariables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};

	programs.neovim = {
		enable = true;
		# viAlias = true;
		# vimAlias = true;

		# withPython3 = true;

		# extraPackages = with pkgs; [
		# 	gnumake
		# 	cargo
		# 	gcc13
		# 	unzip
		# 	wget
		# 	curl
		# 	tree-sitter
		# 	python311Packages.pynvim
		# 	python311Packages.pip
		# ];
	};

	# xdg.configFile.nvim.source = ../nvim;
}