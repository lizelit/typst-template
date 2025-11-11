
{
  description = "Typst document project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        documentName = "main";

        typstDocument = pkgs.stdenv.mkDerivation {
          name = "${documentName}";
          src = ./.;

          buildInputs = [ pkgs.typst ];

          buildPhase = ''
            typst compile ${documentName}.typ
          '';

          installPhase = ''
            mkdir -p $out
            cp ${documentName}.pdf $out/
          '';
        };
      in
      {
        packages = {
          default = typstDocument;
          document = typstDocument;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            typst
            tinymist
          ];

          shellHook = ''
            echo "Typst development environment"
            echo "typst version: $(typst --version)"
            echo ""
            echo "Usage:"
            echo "  typst compile ${documentName}.typ         # compile"
            echo "  typst watch ${documentName}.typ           # watch"
            unset SOURCE_DATE_EPOCH
          '';
        };

        apps = {
          default = {
            type = "app";
            program = "${pkgs.writeShellScript "build-typst" ''
              ${pkgs.typst}/bin/typst compile ${documentName}.typ
              echo "Document compiled to ${documentName}.pdf"
            ''}";
          };

          watch = {
            type = "app";
            program = "${pkgs.writeShellScript "watch-typst" ''
              ${pkgs.typst}/bin/typst watch ${documentName}.typ
            ''}";
          };
        };
      }
    );
}
