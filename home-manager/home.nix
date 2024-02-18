{ pkgs, config, lib, username, ... }:

let
	homeDirectory = "/home/${username}";
in
{
	imports = [
		./ags.nix
		# ./dconf.nix
		./firefox.nix
		# ./git.nix
		./hyprland.nix
		./kitty.nix
		./neovim.nix
		./starship.nix
		./vscode.nix
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
			package = pkgs.catppuccin-gtk;
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

	services = {
		kdeconnect = {
			enable = true;
			indicator = true;
		};
	};

	programs.home-manager.enable = true;
	home.stateVersion = "22.11";
}