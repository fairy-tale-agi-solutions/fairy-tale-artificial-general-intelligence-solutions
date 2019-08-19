{ pkgs ? import <nixpkgs> {}
, compiler ? "ghc864" 
}:
with pkgs;
stdenv.mkDerivation rec {
  name = "agi";
  src = ../.;
  ghc = haskell.packages.${compiler}.ghcWithHoogle (ps: with ps; [
            base hint placeholders template-haskell 
        ]);
  buildInputs = [ ghc ];
  buildPhase = ''
    ghc ./app/Main.hs 
  '';
  installPhase = ''
    cp ./app/Main $out
  '';
} 
