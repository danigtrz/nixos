{ config, pkgs, ... }:


{
	home.packages = with pkgs; [ hypridle ];

	home.file."hypr/hypridle.conf".text = ''
		general {
			lock_cmd = pidof swaylock || swaylock
			before_sleep_cmd = loginctl lock-session
			after_sleep_cmd = hyprctl dispatch dpms on
		}

		listener {
			timeout = 300
			on-timeout = brightnessctl -s set 10
			on-resume = brightnessctl -r
		}

		listener {
			timeout = 600
			on-timeout = loginctl lock-session
		}

		listener {
			timeout = 610
			on-timeout = hyprctl dispatch dpms off
			on-resume = hyprctl dispatch dpms on
		}

		listener {
			timeout = 1800
			on-timeout = systemctl suspend
		}
	'';
}