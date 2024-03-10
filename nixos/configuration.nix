flake-overlays:

{ pkgs, config, options, lib, username, hostname, ... }:

{
	imports = [
		./hardware-configuration.nix
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

	# user
	users.users.${username} = {
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
	};

	# network
	networking = {
		hostName = hostname;
		networkmanager.enable = true;
	};

	# shell
	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];

	# dconf
	programs.dconf.enable = true;

	# bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = false;
	};

	system.stateVersion = "23.05";
}