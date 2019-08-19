{ mkDerivation, base, hedgehog, hedgehog-fn, hint, hpack
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
}
