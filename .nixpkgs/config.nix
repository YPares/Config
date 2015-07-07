{
    packageOverrides = super: let self = super.pkgs; in
    {
        myHaskellEnv =
        self.haskellPackages.ghcWithPackages
            (haskellPackages: with haskellPackages; [
                mtl QuickCheck random text vector alex happy cabal-install cpphs]);
    };
}
