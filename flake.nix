{
  description = "Flake for running ansible scripts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, flake-utils, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlays.default
          ];
        };
    in
      {
        devShells.default =
          pkgs.devshell.mkShell {
            packages = [
              pkgs.ansible
              pkgs.tree
            ];
            commands = [
              {
                name = ''new-role'';
                help = ''scaffolds new role with given name'';
                category = ''ansible-tasks'';
                command =
                  ''
                    ROLESDIR=$(git rev-parse --show-toplevel)/roles/$1
                    mkdir -p $ROLESDIR/{tasks,templates,files,defaults,meta}
                    touch $ROLESDIR/{tasks,defaults,meta}/main.yml
                    echo "# $1" >> $ROLESDIR/README.md
                    echo "new role created: "
                    tree $ROLESDIR
                  '';
              }
            ];
          };
      });
}
