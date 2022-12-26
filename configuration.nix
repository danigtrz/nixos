flake-overlays:

{ config, pkgs, options, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix 
    ./modules/programs/waybar/waybar.nix
  ]; 

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # hostname
  networking.hostName = "nixos";

  # enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;

  # time zone
  time.timeZone = "America/Tijuana";

  # internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  # user
  users.users.rafa = {
    isNormalUser = true;
    description = "Rafa";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    # packages = with pkgs; [];
  };

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # nvidia and graphics
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gcc
    python3
    p7zip
    zip
    unzip
    glxinfo
    killall
    firefox
    kitty
    wofi
    dunst
    ranger
    pipewire
    wireplumber
    alsa-lib
    alsa-utils
    flac
    hyprpaper
    wayland
    wayland-scanner
    wayland-utils
    wayland-protocols
    xwayland
    egl-wayland
    wl-clipboard
    wlr-randr
    neofetch
    zathura
    pciutils
    vulkan-tools
    lutris
    krita
    gimp
    inkscape
  ];

  # light
  programs.light.enable = true;

  # fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];

  # cachix for hyprland
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nixpkgs.overlays = flake-overlays;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  security.rtkit.enable = true;

  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # flatpak
  services.flatpak.enable = true;

  # openssh
  # services.openssh.enable = true;

  system.stateVersion = "22.11";
}
