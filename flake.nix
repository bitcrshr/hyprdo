{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        elixir = pkgs.beam.packages.erlang.elixir;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # flake
            nixpkgs-fmt
            nil

            # elixir
            elixir
            elixir_ls
            glibcLocales

            # protobufs/grpc
            buf
            protoc-gen-elixir

            # sqlite
            sqlite

            # util
            ranger
            grpcurl
          ];
        };
      }
    );

}
