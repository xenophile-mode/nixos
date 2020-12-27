# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nix-thinkpad"; # Define your hostname.
  # networking.wireless.enable = true;   # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  


  # Set your time zone.
  time.timeZone = "America/Chicago";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
    };

  # Enable Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+dwm"; 
  services.xserver.windowManager.dwm.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver = {
    xkbOptions = "caps:swapescape";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xenophile = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget 
     vim
     firefox
     xfce.xfce4-terminal	
     pywal
     feh
     imagemagick
     picom
     i3
     xfce.thunar
     fff
     glances
     cmus 
     canto-curses
     pulseeffects
     qutebrowser
     pavucontrol
     soulseekqt
     mpv
     rofi
     nano
     bashmount
     ntfs3g
     exfat
     udevil
     zsh
     htop
     nmon
     ytop
     neofetch
     haxor-news
     next
     libnma
     openvpn
     networkmanager-openvpn
     alacritty
     termite
     i3lock
     gtypist
     weechat
     ranger
     kitty
     git
     micro
     python3
     cmake
     nodejs
     unzip
     ibm-plex
     nerdfonts
     rtorrent
     googler
     neo-cowsay
     wireguard-tools
     mullvad-vpn
     protonvpn-cli
     dwm
     dmenu
     home-manager
     gnupatch
     xorg.xinit
     cmake
     gnumake
     pkg-config-unwrapped
     freetype
     haskellPackages.freetype2
     st
     ly
  ];

fonts.fonts = with pkgs; [
  ibm-plex
  nerdfonts
];

  nixpkgs.config.allowUnfree = true;

  
  nixpkgs.config.dmenu.patches = [
    /home/xenophile/dmenu-center-4.8.diff
    ];

  nixpkgs.config.dwm.patches = [
     /home/xenophile/dwm-fixborders-6.2.diff
     /home/xenophile/dwm-uselessgap-20200719-bb2e722.diff
    ];
    

  nixpkgs.config.st.patches = [
      /home/xenophile/st-blinking_cursor-20200531-a2a7044.diff
      /home/xenophile/st-bold-is-not-bright-20190127-3be4cf1.diff
      /home/xenophile/st-alpha-0.8.2.diff
    ];



  # Enable device auto-mounting
  services.devmon.enable = true;
  
  #Set zsh as shell for a user
  users.extraUsers.xenophile = {
      shell = pkgs.zsh;
    };



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

