{
  description = "cipepser's home-manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      # ホストごとの差分はここと hosts/ 配下だけで管理する。
      # username を key にしているので `home-manager switch --flake .#<username>` で切り替わる。
      hosts = {
        # 仕事用 Mac (Apple Silicon)
        "masanori.onda" = {
          system = "aarch64-darwin";
          module = ./hosts/work.nix;
        };
        # 個人用 Mac (Apple Silicon / M2)
        "cipepser" = {
          system = "aarch64-darwin";
          module = ./hosts/personal.nix;
        };
      };

      mkHome = _username: { system, module }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [ ./home.nix module ];
        };
    in {
      homeConfigurations = builtins.mapAttrs mkHome hosts;
    };
}
