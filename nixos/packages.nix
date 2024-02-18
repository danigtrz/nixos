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
		# mathematica

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
		pipewire
		wireplumber
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


		# file manager
		xfce.thunar
		gnome.file-roller

		# image applications
		inkscape
		krita
		gimp

		# desktop utilities
		hyprpaper
		dunst
		wofi

		# multimedia
		mpv
		vlc
		feh

		# steam
		steam-run
		# (steam.override { withJava = true; })

		# spotify
		spotify
		spotifywm
		spicetify-cli

		# misc. applications
		networkmanagerapplet
		# protonvpn-gui
		# protonvpn-cli
		libreoffice-fresh
		bitwig-studio
		qbittorrent
		lutris
		discord
		calibre
		# baobab
		# piper
		# libratbag
	];

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];

	programs.light.enable = true;

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" ]; })
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-cjk-serif
		noto-fonts-emoji
		noto-fonts-extra
		liberation_ttf
		dejavu_fonts
		font-awesome
	];

	programs.thunar.plugins = with pkgs.xfce; [
		thunar-volman
		thunar-archive-plugin
		thunar-media-tags-plugin
	];
	services.tumbler.enable = true;

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	programs.java.enable = true;
}