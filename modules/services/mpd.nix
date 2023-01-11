{ config, lib, pkgs, ... }:

{
	services.mpd = {
		enable = true;
		musicDirectory = "${home.homeDirectory}/Music";
		user = "rafa";
		extraConfig = ''
			audio_output {
				type "pipewire"
				name "PipeWire Sound Server"
			}
		'';
	};
}
