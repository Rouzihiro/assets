{
  description = "A collection of assets (wallpapers, avatars, lockscreen)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    packages.x86_64-linux.assets = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "assets";
      src = ./.;
      installPhase = ''
        mkdir -p $out
        cp -r $src/wallpapers $out/
        cp -r $src/wallpapers-live $out/
        cp -r $src/avatars $out/
        cp -r $src/lockscreen $out/
        cp -r $src/icons $out/
      '';
    };
  };
}
