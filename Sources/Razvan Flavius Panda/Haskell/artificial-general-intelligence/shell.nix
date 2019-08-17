{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, hedgehog, hedgehog-fn, hint, hpack
      , placeholders, stdenv, template-haskell
      }:
      mkDerivation {
        pname = "artificial-general-intelligence";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [
          base hint placeholders template-haskell
        ];
        libraryToolDepends = [ hpack ];
        executableHaskellDepends = [ base ];
        testHaskellDepends = [ base hedgehog hedgehog-fn ];
        preConfigure = "hpack";
        homepage = "https://github.com/razvan-panda/artificial-general-intelligence#readme";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
