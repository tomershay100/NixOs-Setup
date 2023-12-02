# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "momo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IL";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "he_IL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  environment.plasma5.excludePackages = with pkgs; [
    libsForQt5.elisa
    libsForQt5.gwenview
    libsForQt5.okular
    libsForQt5.khelpcenter
    libsForQt5.konsole
    libsForQt5.plasma-browser-integration
    libsForQt5.print-manager
    libsForQt5.kate
    libsForQt5.ark
    libsForQt5.kcalc
    libsForQt5.kwallet
    libsForQt5.kwalletmanager
    libsForQt5.ktimer
    xterm
    # emoji selector    
  ];
  programs.dconf.enable = true;

  services.xserver.layout = "us,il";
  services.xserver.xkbVariant = "neo";

  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "tomers";
  # services.xserver.xkbOptions = "numpad:microsoft";
  # Configure keymap in X11
  # services.xserver = {
  #   layout = "us,il";
  #   xkbVariant = "";
  # } ;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tomers = {
    isNormalUser = true;
    home = "/home/tomers";
    description = "Tomer Shay";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$sEt.Cbg3Hb//4RVA7At7B1$2jrF8ncZyvWJaf65TY5M/o43z6ALLrXVyWfethFowM/";
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };
  users.mutableUsers = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    zsh
    curl
    oh-my-zsh
    gparted
    telegram-desktop
    gnome.gedit # text editor
    gnucash # manage money
    libreoffice-qt # office apps
    okular # document viewer tool
    kdenlive # video editing tool
    gimp # image editing tool
    feh # image viewer tool
    terminator # terminal app
    sublime3 # text editor 
    qalculate-qt # calculator
    google-chrome
    python3
    (python3.withPackages( ps: with ps; [ pandas requests ]))
    konsave
  ];
  # peazip  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "23.11"; # Did you read the comment?
  system.autoUpgrade.channel = "https://channels.nixos.org.nixos-23.11";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    histSize = 1000000;
    histFile = "$HOME/.zsh_history";

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" "sudo" ];
      theme = "fino-time-ts";
      custom = "/home/tomers/Desktop/NixOSConfiguration/";
    };

    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = [ "main" "brackets" "pattern" "cursor" "line" ];
  };
  programs.plotinus.enable = true;

  nix.gc.automatic = true;
}
