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

		ags.url = "github:Aylur/ags";

		nix-matlab = {
			url = "gitlab:doronbehar/nix-matlab";
		};
	};

	outputs = { nixpkgs, home-manager, ... }@inputs:

	let
		user = "rafa";
		hostname = "nixos"
		system = "x86_64-linux";
		
		pkgs = import nixpkgs {
			inherit system;
			config.allowUnfree = true;
		};
		
		flake-overlays = [
			nix-matlab.overlay
		];
	
	in {
		nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs username hostname system;
			};

			modules = [
				(import ./nixos/configuration.nix flake-overlays)

				# home-manager.nixosModules.home-manager {
				# 	home-manager.useGlobalPkgs = true;
				# 	home-manager.useUserPackages = true;
				# 	home-manager.users.rafa = {
				# 		imports = [ ./home.nix ];
				# 	};
				# }

				hyprland.nixosModules.default
				{ programs.hyprland = {
					enable = true;
				}; }
			];

			homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = { inherit inputs username; };
				modules = [ ./home-manager/home.nix ];
			};
		};
	};
}
