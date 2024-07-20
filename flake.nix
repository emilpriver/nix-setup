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
  };
  outputs = {
    self,
    nixpkgs,
    ocamlOverlay,
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
        ncdu
        google-cloud-sql-proxy
        fzf

        # Programs
        slack
        discord
        signal-desktop
        charm-freeze
        hoppscotch
        tor-browser
        gitkraken
        git-cliff
        terraform
        postman

        #ide
        zed-editor
        neovim
        bruno

        # ocaml
        ocamlPkgs.dune_3
        ocamlPkgs.opam
        ocamlPkgs.ocaml
        ocamlPkgs.ocamlPackages.findlib
        ocamlPkgs.dune-release
        ocamlPkgs.ocamlPackages.ocaml-lsp
        ocamlPkgs.ocamlPackages.ocamlformat

        # golang
        go
        gofumpt

        # rust
        rustup

        # Javascript
        nodePackages_latest.pnpm
        nodejs_22

        # docker
        docker
        docker-compose
      ];
    };
  };
}
