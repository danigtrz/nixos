{ config, lib, pkgs, ... }:

{
	imports = [
		# programs
		# ./modules/programs/hyprland.nix
		./modules/programs/zsh.nix
		./modules/programs/starship.nix
		./modules/programs/neovim/neovim.nix
		./modules/programs/kitty.nix
		./modules/programs/vscode.nix
		./modules/programs/zathura.nix
		./modules/programs/ncmpcpp.nix

		# services
		# ./modules/services/mpd.nix
	];

	home.username = "rafa";
	home.homeDirectory = "/home/rafa";

	home.sessionVariables = {
		EDITOR = "nvim";
		BROWSER = "firefox";
		TERMINAL = "kitty";
		QT_QPA_PLATFORMTHEME = "gtk3";
		QT_SCALE_FACTOR = "1";
		MOZ_ENABLE_WAYLAND = "1";
		SDL_VIDEODRIVER = "x11";
		QT_QPA_PLATFORM = "wayland";
		QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
		QT_AUTO_SCREEN_SCALE_FACTOR = "1";
		CLUTTER_BACKEND = "wayland";
		NIXOS_OZONE_WL = "1";
		XDG_CURRENT_DESKTOP = "Hyprland";
		XDG_SESSION_DESKTOP = "Hyprland";
		
		XDG_CACHE_HOME  = "\${HOME}/.cache";
		XDG_CONFIG_HOME = "\${HOME}/.config";
		XDG_BIN_HOME    = "\${HOME}/.local/bin";
		XDG_DATA_HOME   = "\${HOME}/.local/share";
		
		# PATH = [ "\${XDG_BIN_HOME}" ];

		# steam GE proton
		STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";

		# hyprland
		_JAVA_AWT_WM_NONREPARENTING = "1";
		XCURSOR_SIZE = "24";

		# hyprland nvidia
		XDG_SESSION_TYPE = "wayland";
		WLR_NO_HARDWARE_CURSORS = "1";
		LIBVA_DRIVER_NAME = "nvidia";
		# GBM_BACKEND = "nvidia-drm";
		# __GLX_VENDOR_LIBRARY_NAME = "nvidia";

		# kitty
		# GLFW_IM_MODULE = "ibus";
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

	home.stateVersion = "22.11";

	programs.home-manager.enable = true;
}
