{
	description = "root flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = github:nix-community/home-manager;
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";

		ags.url = "github:Aylur/ags";

		nix-matlab = {
			url = "gitlab:doronbehar/nix-matlab";
		};
	};

	outputs = { nixpkgs, home-manager, hyprland, ags, nix-matlab, ... }@inputs:

	let
		username = "daniel";
		hostname = "nixos";
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

				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.${username} = {
						imports = [ ./home-manager/home.nix ];
					};
					home-manager.extraSpecialArgs = { inherit inputs username; };
				}
			];
		};
	};
}
