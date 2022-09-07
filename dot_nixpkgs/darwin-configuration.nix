{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
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
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  nix.extraOptions = ''
    experimental-features = nix-command
  '';

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
