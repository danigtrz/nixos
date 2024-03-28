{ config, pkgs, ... }:
{
	home.packages = with pkgs; [ swaylock-effects ];

	home.file."sway/lock.conf".text = ''
		swaylock
	'';
}