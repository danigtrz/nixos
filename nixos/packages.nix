{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# utilities (general)
		asdf-vm
		brightnessctl
		fd
		gamemode
		lazygit
		networkmanagerapplet
		pciutils
		pdftk
		psmisc
		ripgrep
		vulkan-tools
		wev
		wget

		# utitlies (media)
		playerctl

		# utilies (screen)
		grim
		slurp
		swww
		wl-clipboard
		wlr-randr

		# utilities (filing/archival/compression)
		file-roller
		p7zip
		unzip
		zip

		# coding
		dotnet-sdk
		gcc
		godot_4
		jupyter
		# mathematica
		python3Full
		texlive.combined.scheme-full

		# programs (cli)
		btop
		neofetch
		ranger

		# programs (gui)
		bitwig-studio
		discord
		libreoffice-fresh
		librewolf
		obsidian
		protonvpn-gui
		qbittorrent
		unityhub

		# programs (media)
		feh
		# jellyfin
		# jellyfin-web
		# jellyfin-ffmpeg
		loupe
		mpv
		spotify
		# spotifywm
		# spicetify-cli

		# programs (images)
		imagemagick
		inkscape
		krita
		gimp

		# games
		lutris
		ppsspp-sdl-wayland
		prismlauncher
	];

	# fonts
	fonts.packages = with pkgs; [
		nerd-fonts.fira-code
		nerd-fonts.roboto-mono
		roboto
		fira-code-symbols
		liberation_ttf
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-emoji
		dejavu_fonts
	];

	# nm-applet
	programs.nm-applet.enable = true;

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
		type = "fcitx5";
		enable = true;
		fcitx5.addons = with pkgs; [
			fcitx5-gtk
			fcitx5-chinese-addons
		];
	};

	# jellyfin
	# services.jellyfin = {
	# 	enable = false;
	# 	openFirewall = false;
	# 	user = "daniel";
	# };

	# redshift
	services.redshift = {
		enable = false;
		temperature = {
			day = 5700;
			night = 3000;
		};
		# dawnTime = "4:00-5:00";
		# duskTime = "6:00-7:00";
	};
}
