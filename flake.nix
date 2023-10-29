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

		nix-matlab = {
			url = "gitlab:doronbehar/nix-matlab";
		};

		aagl.url = "github:ezKEa/aagl-gtk-on-nix";
		aagl.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, hyprland, nix-matlab, aagl }:
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
						enableNvidiaPatches = true;
					}; }

					{
						imports = [ aagl.nixosModules.default ];
						nix.settings = aagl.nixConfig; # set up cachix
						programs.anime-game-launcher.enable = true; # adds launcher and /etc/hosts rules
						programs.honkers-railway-launcher.enable = true;
						programs.honkers-launcher.enable = true;
					}
				];
			};
		};
	};
}
