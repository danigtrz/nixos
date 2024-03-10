{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [

		# utilities
		fd
		pciutils
		pdftk
		psmisc
		ripgrep
		vulkan-tools
		wev
		wget

		# archival/compression
		unzip
		zip

		# cli programs/tools
		btop
		neofetch
		ranger

		# coding
		gcc
		jupyter
		mathematica
		python3
		texlive.combined.scheme-full

		# file manager
		xfce.thunar
		gnome.file-roller

		# media
		loupe
		mpv
		vlc

		# applications
		bitwig-studio
		discord
		libreoffice-fresh
		lutris
		qbittorrent

		# image editing
		inkscape
		krita
		gimp

		# spotify
		spotify
		spotifywm
		spicetify-cli
	];

	# fonts
	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "RobotoMono" "FiraCode" ]; })
		roboto
		fira-code-symbols
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		liberation_ttf
		dejavu_fonts
	];

	# thunar
	programs.thunar.plugins = with pkgs.xfce; [
		thunar-volman
		thunar-archive-plugin
		thunar-media-tags-plugin
	];
	services.tumbler.enable = true;

	# steam
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};
	programs.java.enable = true;

	# fcitx5
	i18n.inputMethod = {
		enabled = "fcitx5";
		fcitx5.addons = with pkgs; [
			fcitx5-gtk
			fcitx5-chinese-addons
		];
	};
}