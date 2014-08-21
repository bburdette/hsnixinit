let pkgs = import <nixpkgs> {};
    haskellPackages = pkgs.haskellPackages.override {
      extension = self: super: {
        scoscdir = self.callPackage ./. {};
      };
    };
 in pkgs.lib.overrideDerivation haskellPackages.scoscdir (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
