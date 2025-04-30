{ inputs, pkgs, ... }:

{
	imports = [ inputs.ags.homeManagerModules.default ];

	programs.ags = {
		enable = true;
		configDir = ../ags;
		extraPackages = with pkgs; [
			inputs.ags.packages.${pkgs.system}.battery
			fzf
		];
	};

	home.packages = [
		(inputs.ags.lib.bundle {
			inherit pkgs;
			src = ../ags;
			name = "desktop-shell"; # executable name
			gtk4 = true;
			entry = "app.ts";
			
			extraPackages = with inputs.ags.packages.${pkgs.system}; [
				apps # app launcher
				mpris # media controls
				hyprland # workspace integration
				bluetooth # bluez integration
				battery 
				wireplumber # used by pipewire
				notifd # desktop notification integration
			];
	  	})
		inputs.ags.packages.${pkgs.system}.io # astal cli
	];
}
