{
  description = "Flake for running ansible scripts";
  inputs.nixpkgs.url = "nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = ["x86_64-linux" "x86_64-darwin"  "aarch64-linux" "aarch64-darwin"];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

    in
      {
        devShells = forAllSystems(system:
          let pkgs = nixpkgsFor.${system};
          in
            {
              default = pkgs.mkShell {
                buildInputs = with pkgs; [ ansible ];
                shellHook = ''
                echo "Welcome to the ansible-shell!"
                '';
              };
            });
      };
}
