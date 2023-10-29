flake-overlays:

{ config, pkgs, options, lib, ... }:

{
	imports = [
		# hardware
		./hardware-configuration.nix

		# waybar
		./modules/programs/waybar/waybar.nix

		# mpd
		./modules/services/mpd.nix
	];

	# overlays
	nixpkgs.overlays = [
		(
			final: prev: {
			steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
				extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
					libgdiplus
				]);
			});
			}
		)
	] ++ flake-overlays;

	# bootloader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot/efi";
	boot.loader.timeout = 1;

	# hostname
	networking.hostName = "nixos";

	# enable networking
	networking.networkmanager.enable = true;
	networking.wireless = {
		# enable = true;
		userControlled.enable = true;
	};

	# time zone
	time.timeZone = "America/Tijuana";

	# internationalisation properties
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# user
	users.users.rafa = {
		isNormalUser = true;
		description = "Rafa";
		extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
		# packages = with pkgs; [];
	};

	# enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# nvidia and graphics
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.nvidia.prime = {
		sync.enable = true;
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:1:0:0";
	};
	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

	# external display
	# specialisation = {
	# 	external-display.configuration = {
	# 		system.nixos.tags = [ "external-display" ];
	# 		hardware.nvidia.prime.offload.enable = lib.mkForce false;
	# 		hardware.nvidia.powerManagement.enable = lib.mkForce false;
	# 	};
	# };

	# display manager
	# services.xserver.displayManager.sddm.enable = true;

	# KDE
	# services.xserver.enable = true;
	# services.xserver.displayManager.sddm.enable = true;
	# services.xserver.desktopManager.plasma5.enable = true;

	# zsh
	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];

	# packages
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
		python310Packages.requests
		python310Packages.beautifulsoup4
		python310Packages.scrapy

		# archival / compression
		p7zip
		zip
		unzip

		# power management
		tlp
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
		swaylock-effects
		swayidle

		# web
		firefox

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
		protonvpn-gui
		protonvpn-cli
		libreoffice-fresh
		bitwig-studio
		qbittorrent
		lutris
		discord
		calibre
		anki
		baobab
		# piper
		# libratbag
	];

	# light
	programs.light.enable = true;

	# steam
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};
	# nixpkgs.config.packageOverrides = pkgs: {
	# 	steam = pkgs.steam.override {
	# 		extraPkgs = pkgs: with pkgs; [
	# 			libgdiplus
	# 		];
	# 	};
	# };
	programs.java.enable = true;

	# fonts
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

	# input
	i18n.inputMethod = {
		enabled = "fcitx5";
		fcitx5.addons = with pkgs; [
			fcitx5-gtk
			fcitx5-rime
			fcitx5-chinese-addons
			fcitx5-table-extra
			# fcitx5-pinyin-moegirl
			# fcitx5-pinyin-zhwiki
		];
	};

	# thunar extras
	programs.thunar.plugins = with pkgs.xfce; [
		thunar-volman
		thunar-archive-plugin
		thunar-media-tags-plugin
	];
	services.gvfs.enable = true;
	services.tumbler.enable = true;

	# cachix
	nix.settings = {
		substituters = [
			"https://hyprland.cachix.org"
		];
		trusted-public-keys = [
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
		];
	};

	# swaylock
	security.pam.services.swaylock = {};

	# xdg portals
	xdg.portal = {
		enable = true;
		# wlr.enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

	security.rtkit.enable = true;

	# authentication agent
	security.polkit.enable = true;

	# systemd = {
	# 	user.services.polkit-gnome-authentication-agent-1 = {
	# 		description = "polkit-gnome-authentication-agent-1";
	# 		wantedBy = [ "graphical-session.target" ];
	# 		wants = [ "graphical-session.target" ];
	# 		after = [ "graphical-session.target" ];
	# 		serviceConfig = {
	# 			Type = "simple";
	# 			ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	# 			Restart = "on-failure";
	# 			RestartSec = 1;
	# 			TimeoutStopSec = 10;
	# 		};
	# 	};
	# };

	# sound
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		jack.enable = true;
		pulse.enable = true;
		wireplumber.enable = true;
	};

	# mpd user workaround
	# services.mpd.user = "rafa";
	# systemd.services.mpd.environment = { XDG_RUNTIME_DIR = "/run/user/1000"; };

	# bluetooth
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;

	# openssh
	# services.openssh.enable = true;

	system.stateVersion = "22.11";
}
