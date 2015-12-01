{
    allowUnfree = true;

    packageOverrides = super: let self = super.pkgs; in
    {
        myHaskellEnv =
        self.haskellPackages.ghcWithPackages
            (p: with p; [mtl QuickCheck random text vector alex happy cabal-install cpphs]);

        profiledHaskellPackages = self.haskellPackages.override {
            overrides = self: super:
              { mkDerivation = args: super.mkDerivation (args // {
                    enableLibraryProfiling = true;
                });
              };
        };

        rEnv = super.rWrapper;
     
    };
}
