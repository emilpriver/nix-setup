# 1. In this dir create a lockfile:
#   nix flake lock --update-input nixpkgs
#
# 2. Install the profile from home dir
#   nix profile install ~/.config/nixpkgs\#default
#
# 3. Update packages
#   nix profile upgrade nixpkgs --impure
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    ocamlOverlay.url = "github:nix-ocaml/nix-overlays";
  ghostty = {
      url = "github:ghostty-org/ghostty";
    };
 };
  outputs = {
    self,
    nixpkgs,
    ocamlOverlay,
    ghostty,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = "${system}";
      config.allowUnfree = true;
    };
    ocamlPkgs = ocamlOverlay.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;
    packages.${system}.default = pkgs.buildEnv {
      name = "tools";
      paths = with pkgs; [
        nix-direnv
        nixfmt-classic
        cachix
        xh
        fd
        tree
        turso-cli
        bun
        yarn
        ncdu
        google-cloud-sql-proxy
        fzf
        inotify-tools
        ghostty.packages.${system}.default
        flyctl
        fastfetch
        lighttpd
        git-standup
        optifine
        xh
        heroic
        virtualenv
        termdbms
        jetbrains.datagrip
        ngrok
        jujutsu
        yq
        television
        pgcli
        tidal-hifi

        # Programs
        slack
        # discord
        signal-desktop
        charm-freeze
        hoppscotch
        tor-browser
        gitkraken
        git-cliff
        terraform
        postman
        git-lfs
        jetbrains.datagrip

        # ide
        # zed-editor
        neovim
        bruno
        kitty

        # ocaml
        ocamlPkgs.ocaml
        ocamlPkgs.ocamlformat
        ocamlPkgs.opam
        ocamlPkgs.ocamlPackages.ocaml-lsp

        # python
        pyenv

        # golang
        go
        gopls
        gofumpt

        # rust
        rustup

        # Javascript
        nodePackages_latest.pnpm
        nodejs_22
        typescript

        # docker
        docker
        docker-compose

        # Elixir & erlang
        elixir
        erlang
        rebar3

        # gleam
        gleam

        # Java
        jre8

        # zig
        zig

        # PHP
        php83Packages.composer
      ];
    };
  };
}
