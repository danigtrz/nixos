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

		# package = config.boot.kernelPackages.nvidiaPackages.stable;
		package = let
			rcu_patch = pkgs.fetchpatch {
				url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
				hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
			};
		in config.boot.kernelPackages.nvidiaPackages.mkDriver {
			version = "535.154.05";
			sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
			sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
			openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
			settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
			persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

			patches = [ rcu_patch ];
		};
	};

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	powerManagement.enable = true;
	services.thermald.enable = true;
	services.tlp.enable = true;
}
