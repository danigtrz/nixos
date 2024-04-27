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

	hardware.nvidia.prime.offload.enableOffloadCmd

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	powerManagement.enable = true;
	services.thermald.enable = true;
	services.tlp.enable = true;

	# asus system services
	services = {
		asusd = {
			enable = true;
			enableUserService = true;
		};
		supergfxd = {
			enable = true;
			settings = {
				vfio_enable = true;
				hotplug_type = "Asus"; 
			};
		};
	};

	systemd.services.supergfxd.path = [ pkgs.pciutils pkgs.lsof ];
}
