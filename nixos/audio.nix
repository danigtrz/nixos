{ pkgs, ... }:

{
	services = {
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			jack.enable = true;
			pulse.enable = true;
			wireplumber.enable = true;
		};

		pulseaudio = {
			enable = false;
			package = pkgs.pulseaudioFull;
		};
	};

	security.rtkit.enable = true;	
}
