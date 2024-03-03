{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [

		# command line utilities
		vim
		wget
		wev
		git
		pciutils
		killall
		playerctl
		grim
		slurp
		pdftk
		neofetch
		ranger
		btop

		# graphics command line utilities
		glxinfo
		vulkan-tools

		# programming
		gcc
		cmake
		SDL2
		SDL2_ttf
		SDL2_gfx
		SDL2_sound
		SDL2_mixer
		SDL2_image
		python3
		jupyter
		pandoc
		texlive.combined.scheme-full
		mathematica

		# python packages
		# python311Packages.ebooklib
		# python310Packages.requests
		# python310Packages.beautifulsoup4
		# python310Packages.scrapy

		# archival / compression
		p7zip
		zip
		unzip

		# power management
		powertop
		thermald

		# sound
		alsa-lib
		alsa-utils
		flac

		# wayland / desktop
		wayland
		wayland-scanner
		wayland-utils
		wayland-protocols
		xwayland
		wlroots
		egl-wayland
		wl-clipboard
		wlr-randr
		swww
		wofi

		# file manager
		xfce.thunar
		gnome.file-roller

		# multimedia
		mpv
		vlc
		feh

		# images
		inkscape
		krita
		gimp

		# music
		spotify
		spotifywm
		spicetify-cli

		# steam
		steam-run
		# (steam.override { withJava = true; })

		# misc. applications
		networkmanagerapplet
		# protonvpn-gui
		# protonvpn-cli
		libreoffice-fresh
		bitwig-studio
		qbittorrent
		lutris
		discord
		# baobab
		# piper
		# libratbag
	];

	# backlight
	programs.light.enable = true;

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