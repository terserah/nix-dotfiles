{
  description = "NixOS unstable + Home-Manager dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    burpsuitepro = {
      url = "github:xiv3r/Burpsuite-Professional";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, burpsuitepro, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
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

