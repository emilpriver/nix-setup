# 1. In this dir create a lockfile:
#   nix flake lock --update-input nixpkgs
#
# 2. Install the profile from home dir
#   nix profile install ~/.config/nixpkgs\#default
#
# 3. Update packages
#   nix profile upgrade nixpkgs --impure

{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "${system}";
        config.allowUnfree = true;
      };
    in {
      packages.${system}.default = pkgs.buildEnv {
        name = "tools";
        paths = with pkgs; [ nix-direnv nixfmt-classic cachix xh fd slack spotify discord zed-editor ];
      };
    };
}
