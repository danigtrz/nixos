{ pkgs, config, libs, ... }:

{
	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement = {
			# enable = true;
			finegrained = true;
		};
		prime = {
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
			# sync.enable = true;
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};

		package = config.boot.kernelPackages.nvidiaPackages.production;
	};

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	powerManagement.enable = true;
	services.thermald.enable = true;
	services.tlp.enable = true;

	environment.systemPackages = with pkgs; [
		asusctl
	];
}
