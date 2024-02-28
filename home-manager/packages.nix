{ pkgs, ... }:

{
	home.packages = with pkgs; [

		mathematica

		# images
		inkscape
		krita
		gimp

		# music
		spotify
		spotifywm
		spicetify-cli
	];
}