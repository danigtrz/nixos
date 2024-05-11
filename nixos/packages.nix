{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# utilities
		asdf-vm
		fd
		gamemode
		lazygit
		pciutils
		pdftk
		playerctl
		psmisc
		ripgrep
		vulkan-tools
		wev
		wget

		# archival/compression
		p7zip
		unzip
		zip

		# cli programs/tools
		btop
		neofetch
		ranger

		# coding
		gcc
		jupyter
		# mathematica
		python3Full
		texlive.combined.scheme-full

		# file manager
		gnome.file-roller

		# pcmanfm
		# pcmanfm
		# lxmenu-data
		# shared-mime-info

		# nemo
		# cinnamon.nemo-with-extensions

		networkmanagerapplet

		# media
		feh
		loupe
		mpv
		# vlc

		# applications
		bitwig-studio
		discord
		libreoffice-fresh
		qbittorrent

		# image editing
		imagemagick
		inkscape
		krita
		gimp

		# spotify
		spotify
		# spotifywm
		# spicetify-cli

		# games
		lutris
		ppsspp-sdl-wayland
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
	programs.thunar = {
		enable = true;
		plugins = with pkgs.xfce; [
			thunar-volman
			thunar-archive-plugin
			thunar-media-tags-plugin
		];
	};
	programs.xfconf.enable = true;

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
