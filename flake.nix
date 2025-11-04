
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
        
        # ドキュメント名を設定
        documentName = "main";
        
        # Typstでドキュメントをビルド
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
        # パッケージ定義
        packages = {
          default = typstDocument;
          document = typstDocument;
        };

        # 開発環境
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            typst
            tinymist       # LSPサーバー（エディタサポート用）
          ];

          shellHook = ''
            echo "Typst development environment"
            echo "typst version: $(typst --version)"
            echo ""
            echo "Usage:"
            echo "  typst compile ${documentName}.typ         # PDFをコンパイル"
            echo "  typst watch ${documentName}.typ           # 変更を監視して自動コンパイル"
          '';
        };

        # アプリケーション定義（nix run用）
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
