{ config, lib, pkgs, ... }:

{
	services.mpd = {
		enable = true;
		musicDirectory = "/home/rafa/Music";
		extraConfig = ''
			audio_output {
				type "pipewire"
				name "PipeWire Sound Server"
			}
		'';
	};
}
