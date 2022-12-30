{ config, lib, pkgs, ... }:

{
	programs.kitty = {
		enable = true;
		settings = {
			enable_audio_bell = false;
			window_padding_width = 8;
			confirm_os_window_close = 0;
		};
		font.name = "Fira Code";
		extraConfig = ''
			# basic colors
			foreground              ${nord6}
			background              ${nord0}
			selection_foreground    ${nord0}
			selection_background    ${nord4}

			# cursor colors
			cursor                  ${nord4}
			cursor_text_color       ${nord0}

			# url underline color when hovering with mouse
			url_color               ${nord4}

			# os window titlebar colors
			wayland_titlebar_color system
			macos_titlebar_color system

			# tab bar colors
			active_tab_foreground   ${nord6}
			active_tab_background   ${nord0}
			inactive_tab_foreground ${nord4}
			inactive_tab_background ${nord0}
			tab_bar_background      ${nord0}

			# colors for marks (marked text in the terminal)
			mark1_foreground ${nord0}
			mark1_background ${nord1}
			mark2_foreground ${nord0}
			mark2_background ${nord2}
			mark3_foreground ${nord0}
			mark3_background ${nord3}

			# the 16 terminal colors

			# black
			color0 ${nord1}
			color8 ${nord2}

			# red
			color1 ${nord11}
			color9 ${nord11}

			# green
			color2  ${nord14}
			color10 ${nord14}

			# yellow
			color3  ${nord13}
			color11 ${nord13}

			# blue
			color4  ${nord9}
			color12 ${nord9}

			# magenta
			color5  ${nord15}
			color13 ${nord15}

			# cyan
			color6  ${nord7}
			color14 ${nord7}

			# white
			color7  ${nord5}
			color15 ${nord4}
		'';
	};
}
