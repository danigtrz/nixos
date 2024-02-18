{ pkgs, ... }:

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
		};
		
		font.name = "FiraCode Nerd Font";
		
		theme = "Catppuccin-Mocha";
		
		keybindings = {
			"ctrl+c" = "copy_or_interrupt";
			"ctrl+v" = "paste_from_clipboard";
			"ctrl+t" = "new_tab";
			"ctrl+w" = "close_tab";
			"ctrl+left" = "previous_tab";
			"ctrl+right" = "next_tab";
		};

		# extraConfig = ''
		# 	# basic colors
		# 	foreground              ${lib.theme.nord6}
		# 	background              ${lib.theme.nord0}
		# 	selection_foreground    ${lib.theme.nord0}
		# 	selection_background    ${lib.theme.nord4}

		# 	# cursor colors
		# 	cursor                  ${lib.theme.nord4}
		# 	cursor_text_color       ${lib.theme.nord0}

		# 	# url underline color when hovering with mouse
		# 	url_color               ${lib.theme.nord4}

		# 	# os window titlebar colors
		# 	wayland_titlebar_color system
		# 	macos_titlebar_color system

		# 	# tab bar colors
		# 	active_tab_foreground   ${lib.theme.nord6}
		# 	active_tab_background   ${lib.theme.nord0}
		# 	inactive_tab_foreground ${lib.theme.nord4}
		# 	inactive_tab_background ${lib.theme.nord0}
		# 	tab_bar_background      ${lib.theme.nord0}

		# 	# colors for marks (marked text in the terminal)
		# 	mark1_foreground ${lib.theme.nord0}
		# 	mark1_background ${lib.theme.nord1}
		# 	mark2_foreground ${lib.theme.nord0}
		# 	mark2_background ${lib.theme.nord2}
		# 	mark3_foreground ${lib.theme.nord0}
		# 	mark3_background ${lib.theme.nord3}

		# 	# the 16 terminal colors

		# 	# black
		# 	color0 ${lib.theme.nord1}
		# 	color8 ${lib.theme.nord2}

		# 	# red
		# 	color1 ${lib.theme.nord11}
		# 	color9 ${lib.theme.nord11}

		# 	# green
		# 	color2  ${lib.theme.nord14}
		# 	color10 ${lib.theme.nord14}

		# 	# yellow
		# 	color3  ${lib.theme.nord13}
		# 	color11 ${lib.theme.nord13}

		# 	# blue
		# 	color4  ${lib.theme.nord9}
		# 	color12 ${lib.theme.nord9}

		# 	# magenta
		# 	color5  ${lib.theme.nord15}
		# 	color13 ${lib.theme.nord15}

		# 	# cyan
		# 	color6  ${lib.theme.nord7}
		# 	color14 ${lib.theme.nord7}

		# 	# white
		# 	color7  ${lib.theme.nord5}
		# 	color15 ${lib.theme.nord4}
		# '';
	};
}