# Lucas' Yale website v. 2017-03-02

# Some code copied and/or modified from
# https://utdemir.com/posts/hakyll-on-nixos.html
{ stdenv, makeWrapper, haskell-env, thirdparty}:

stdenv.mkDerivation {
  name = "blog-generator";
  src = ./.;
  phases = "unpackPhase buildPhase";
  buildInputs = [
    makeWrapper
    haskell-env
  ];
  buildPhase = ''
    mkdir -p $out/bin
    ghc -O2 -dynamic --make Site.hs -o $out/bin/generate-site

    wrapProgram $out/bin/generate-site --set 'THIRDPARTY' '${thirdparty}' 
  '';
}
