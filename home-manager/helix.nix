{ pkgs, config, ... }:

{
	home.packages = with pkgs; [
		helix
	];

	programs.helix = {
		enable = true;
		settings = {
			editor.cursor-shape = {
				normal = block;
				insert = bar;
				select = bar;
			};
		};
	};
}