{
	description = "root flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = github:nix-community/home-manager;
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland = {
			url = "github:hyprwm/Hyprland";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# stylix = {
		# 	url = "github:danth/stylix";
		# };

		nix-matlab = {
			url = "gitlab:doronbehar/nix-matlab";
		};
	};

	outputs = { self, nixpkgs, home-manager, hyprland, nix-matlab }:
	let
		system = "x86_64-linux";
		
		pkgs = import nixpkgs {
			inherit system;
			config.allowUnfree = true;
		};
		
		flake-overlays = [
			nix-matlab.overlay
		];
	
	in {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					(import ./configuration.nix flake-overlays)

					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.rafa = {
							imports = [ ./home.nix ];
						};
					}

					hyprland.nixosModules.default
					{ programs.hyprland = {
						enable = true;
						nvidiaPatches = true;
					}; }

					# stylix.nixosModules.stylix
					# {
                    #     stylix.image = ./wallpapers/3_nap3_4k.jpg;
                    #     stylix.polarity = "dark";
					# }
				];
			};
		};
	};
}
