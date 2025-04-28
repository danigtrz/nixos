{ pkgs, config, lib, ... }:

{
	# display backlight
	boot.kernelParams = [
		"i915.enable_dpcd_backlight=1"
		"nvidia.NVreg_EnableBacklightHandler=0"
	];

	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement = {
			enable = false;
			finegrained = false;
		};

		prime = {
			# offload = {
			# 	enable = false;
			# 	enableOffloadCmd = false;
			# };
			sync.enable = true;
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};

		open = false;

		nvidiaSettings = true;

		package = config.boot.kernelPackages.nvidiaPackages.stable;

		dynamicBoost.enable = lib.mkDefault true;
	};

	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};

	powerManagement.enable = true;
	services.thermald.enable = true;
	services.tlp.enable = true; # switched to false while installing gnome

	# asus system services
	services = {
		asusd = {
			enable = lib.mkDefault true;
			enableUserService = true;
		};
		supergfxd.enable = true;
	};

	systemd.services.supergfxd.path = [ pkgs.pciutils ];
}
