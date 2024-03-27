{ pkgs, config, lib, username, ... }:

let
	homeDirectory = "/home/${username}";
in
{
	imports = [
		./ags.nix
		./firefox.nix
		./git.nix
		./helix.nix
		./hyprland.nix
		./kitty.nix
		./neovim.nix
		./starship.nix
		./vscode.nix
		./zathura.nix
		./zsh.nix
	];

	news.display = "show";

	nix = {
		# package = pkgs.nix;
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			warn-dirty = false;
		};
	};

	home = {
		inherit username homeDirectory;

		sessionVariables = {
			QT_XCB_GL_INTEGRATION = "none"; # kdeconnect
			NIXPKGS_ALLOW_UNFREE = "1";
			NIXPKGS_ALLOW_INSECURE = "1";
			
			STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
		};

		sessionPath = [
			"$HOME/.local/bin"
		];
	};

	gtk = {
		enable = true;
		theme = {
			name = "Catppuccin-Mocha-Pink";
			package = pkgs.catppuccin-gtk.override {
				accents = [ "pink" ];
				variant = "mocha";
			};
		};
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};
		cursorTheme = {
			name = "Bibata-Modern-Ice";
			package = pkgs.bibata-cursors;
			size = 24;
		};
		font = {
			name = "DejaVu Sans";
			size = 11;
		};
	};

	xdg.configFile = {
		"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
		"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
		"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
	};

	programs.home-manager.enable = true;
	home.stateVersion = "22.11";
}