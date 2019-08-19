{ pkgs             ? import <nixpkgs>{} 
, depsToVSCodePath ? [] 
}:
let 
vscode = 
  pkgs.vscode-with-extensions.override {
      # When the extension is already available in the default extensions set.
      vscodeExtensions = with pkgs.vscode-extensions;
      [
        bbenoist.Nix
      ]
      ++
      # Concise version from the vscode market place when not available in the default set.
      pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "theme-dracula-at-night";
          publisher = "bceskavich";
          version = "2.5.0";
          sha256 = "03wxaizmhsq8k1mlfz246g8p8kkd21h2ajqvvcqfc78978cwvx3p";
        }
        {
          name = "vsc-material-theme";
          publisher = "equinusocio";
          version = "2.8.2";
          sha256 = "04hixd2bv7dd46pcs4mflr7xzfz273zai91k67jz6589bd8m93av";
        }
        # {
        #   name = "gitlens";
        #   publisher = "eamodio";
        #   version = "9.5.1";
        #   sha256 = "10s2g98wv8i0w6fr0pr5xyi8zmh229zn30jn1gg3m5szpaqi1v92";
        # }
        {
          name = "vscode-hie-server";
          publisher = "alanz";
          version = "0.0.28";
          sha256 = "1gfwnr5lgwdgm6hs12fs1fc962j9hirrz2am5rmhnfrwjgainkyr";
        }
        {
          name = "language-haskell";
          publisher = "justusadam";
          version = "2.6.0";
          sha256 = "1891pg4x5qkh151pylvn93c4plqw6vgasa4g40jbma5xzq8pygr4";
        }
        # {
        #   name = "brittany";
        #   publisher="maxgabriel";
        #   version="0.0.6";
        #   sha256= "1v47an1bad5ss4j5sajxia94r1r4yfyvbim5wax4scr0d5bdgv54";
        # }
      ];
  };
  in
  pkgs.runCommand "${vscode.name}" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
      mkdir -p $out/bin
      makeWrapper \
        ${vscode}/bin/code \
        $out/bin/code \
        --prefix PATH : ${pkgs.lib.makeBinPath depsToVSCodePath}
  ''
