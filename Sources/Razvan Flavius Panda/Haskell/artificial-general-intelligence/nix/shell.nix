{
  pkgs         ? import <nixpkgs>{}
  , withVSCode ? true
  , withHie    ? true
}:
let 
 vscode = ghc: import ./vscode.nix { 
    depsToVSCodePath = [ ghc ] ++ (if withHie then [ (import ./hie.nix) ] else []);
 };
in 
(import ./default.nix {}).overrideAttrs (d: {
  buildInputs = 
    d.buildInputs ++
    [
      (import ./hie.nix)
        pkgs.figlet
    ] 
    ++ ( if withVSCode then [ (vscode d.ghc) ] else []);
  shellHook = ''
    figlet 'Hello AGI' 
  '';
})
