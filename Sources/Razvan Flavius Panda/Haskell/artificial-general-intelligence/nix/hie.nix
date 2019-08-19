let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in # Install stable HIE for GHC 8.6.4
  (all-hies.selection { selector = p: { inherit (p) ghc864; }; })
