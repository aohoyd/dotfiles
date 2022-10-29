{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.kitty
      pkgs.vim
      pkgs.fish
      pkgs.chezmoi
      pkgs.zellij
      pkgs.viddy
      pkgs.bat
      pkgs.exa
      pkgs.fd
      pkgs.fzf
      pkgs.jq
      pkgs.yq
      pkgs.ripgrep
      pkgs.tldr
      pkgs.curlie
      pkgs.podman
      pkgs.qemu
      pkgs.docker-client
      pkgs.asdf-vm
      pkgs.go_1_19
      pkgs.kind
      pkgs.minikube
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  nix.extraOptions = ''
    experimental-features = nix-command
  '';

  # Create /etc/zshrc that loads the nix-darwin environment.
  security.pam.enableSudoTouchIdAuth = true;

  programs = {
    fish.enable = true;
  };

  environment.shells = [ pkgs.fish ];

  users.users.schickling = {
    home = "/Users/schickling";
    shell = "${pkgs.fish}/bin/fish";
  };
  users.users.root = {
    home = "/var/root";
    shell = "${pkgs.fish}/bin/fish";
  };
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
