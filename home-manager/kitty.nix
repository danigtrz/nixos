{ pkgs, config, lib, ... }:

{
	home = {
		sessionVariables.TERMINAL = "kitty";
	};

	programs.kitty = {
		enable = true;
		
		settings = {
			cursor_shape = "beam";
			enable_audio_bell = false;
			window_padding_width = 8;
			confirm_os_window_close = 0;
			background_opacity = "0.85";
			background_blur = 0;
		};
		
		font.name = "OverpassM Nerd Font";
		font.size = 12;
		
		themeFile = "Catppuccin-Mocha";
		
		keybindings = {
			"ctrl+c" = "copy_or_interrupt";
			"ctrl+v" = "paste_from_clipboard";
		};
	};
}
