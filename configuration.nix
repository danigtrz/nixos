flake-overlays:

{ config, pkgs, options, lib, ... }:

{
	imports = [
		# hardware
		./hardware-configuration.nix

		# waybar
		./modules/programs/waybar/waybar.nix
	]; 

	# bootloader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot/efi";
	boot.loader.timeout = 1;

	# hostname
	networking.hostName = "nixos";

	# enable networking
	networking.networkmanager.enable = true;
	# networking.wireless.enable = true;

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

	# zsh
	programs.zsh = {
		enable = true;
		shellAliases = {
			re = "sudo nixos-rebuild switch --flake .#"; 
		};
	};
	users.defaultUserShell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];

	# packages
	environment.systemPackages = with pkgs; [

		# command line utilities
		vim
		wget
		git
		killall
		pciutils

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
		texlive.combined.scheme-full

		# archival / compression
		p7zip
		zip
		unzip

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

		# web
		firefox

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
		feh

		# steam
		steam-run
		(steam.override { withJava = true; })

		# spotify
		spotify
		spotifywm
		spicetify-cli

		# misc. command line applications
		neofetch
		ranger

		# misc. applications
		libreoffice-fresh
		lutris
		discord
	];

	# light
	programs.light.enable = true;

	# steam
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};
	nixpkgs.config.packageOverrides = pkgs: {
		steam = pkgs.steam.override {
			extraPkgs = pkgs: with pkgs; [
				libgdiplus
			];
		};
	};
	programs.java.enable = true;

	# fonts
	fonts.fonts = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-cjk-serif
		noto-fonts-emoji
		noto-fonts-extra
		liberation_ttf
		fira-code
		fira-code-symbols
		dejavu_fonts
		font-awesome
	];

	# cachix for hyprland
	nix.settings = {
		substituters = ["https://hyprland.cachix.org"];
		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
	};

	nixpkgs.overlays = flake-overlays;

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

	security.rtkit.enable = true;

	# sound
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		jack.enable = true;
		pulse.enable = true;
		wireplumber.enable = true;
	};

	# bluetooth
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;

	# openssh
	# services.openssh.enable = true;

	system.stateVersion = "22.11";
}
