flake-overlays:

{ pkgs, config, options, lib, username, hostname, ... }:

{
	imports = [
		./hardware-configuration.nix

		./audio.nix
		./gnome.nix
		./hyprland.nix
		./laptop.nix
		./locale.nix
		./packages.nix
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

	# nix
	documentation.nixos.enable = false;
	nixpkgs.config.allowUnfree = true;
	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			auto-optimise-store = true;
		};
	};

	# kernel
	boot.kernelPackages = pkgs.linuxPackages_latest;
	
	# bootloader
	boot = {
		# tmp.cleanOnBoot = true;
		loader = {
			timeout = 2;
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			# grub = {
			#	enable = true;
			#	device = "nodev";
			#	useOSProber = true;
			# };
		};
	};

	# luks
	boot.initrd.luks.devices."luks-35a9d841-a7b5-4973-a253-c6e5fe5d2cc7".device = "/dev/disk/by-uuid/35a9d841-a7b5-4973-a253-c6e5fe5d2cc7";

	# X11 keymap
	services.xserver.xkb = {
		layout = "us";
		variant = "altgr-intl";
	};

	# user
	users.users.${username} = {
		isNormalUser = true;
		description = "Daniel";
		extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
	};

	# network
	networking = {
		hostName = hostname;
		networkmanager.enable = true;
	};

	# display manager
	# services.displayManager.sddm = {
	# 	enable = true;
	# 	wayland.enable = true;
	# };

	# shell
	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];

	# dconf
	programs.dconf.enable = true;

	# bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		settings = {
			General = {
				Enable = "Source,Sink,Media,Socket";
			};
		};
	};
	services.blueman.enable = true;

	# storage optimisation
	nix.optimise.automatic = true;
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

	# kdeconnect
	programs.kdeconnect.enable = true;
	networking.firewall = rec {
		allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
		allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
	};

	# files, mounting, access, etc.
	services = {
		gvfs.enable = true;
		tumbler.enable = true;
		udisks2.enable = true;
		devmon.enable = true;
		upower.enable = true;
		accounts-daemon.enable = true;
	};
	
	# virtualisation
	# virtualisation.virtualbox.host.enable = true;
	# virtualisation.virtualbox.host.enableExtensionPack = true;
	# users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

	system.stateVersion = "23.11";
}
