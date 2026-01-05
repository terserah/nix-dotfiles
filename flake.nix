{
  description = "NixOS unstable + Home-Manager dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";


    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    burpsuitepro = {
      url = "github:xiv3r/Burpsuite-Professional";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, burpsuitepro, ... }: {
    nixosConfigurations = {
      catnux = nixpkgs.lib.nixosSystem {
        # system = "x86_64-linux";
        modules = [
          ./hosts/catnux/configuration.nix
	        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit burpsuitepro;
            };

            home-manager.users.tabun = import ./home/home.nix;
          }
        ];
        specialArgs = { inherit self burpsuitepro; };
      };
    };

  };
}

