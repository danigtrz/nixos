flake-overlays:

{ pkgs, username, hostname, ... }:

{
	imports = [
		/etc/nixos/hardware-configuration.nix
		./audio.nix
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
			experimental-features = "nix-command flakes";
			auto-optimise-store = true;
		};
	};

	# bootloader
	boot = {
		# tmp.cleanOnBoot = true;
		loader = {
			timeout = 2;
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			efi.efiSysMountPoint = "/boot/efi";
		};
	};

	# network
	networking = {
		hostName = hostname;
		networkmanager.enable = true;
	};

	# bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = false;
	};

	# dconf
	programs.dconf.enable = true;

	# user
	users.users.${username} = {
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
	};

	# kdeconnect
	networking.firewall = rec {
		allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
		allowedUDPPortRanges = allowedTCPPortRanges;
	};

	system.stateVersion = "23.05";
}