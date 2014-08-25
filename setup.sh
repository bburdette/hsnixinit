INSTDIR=$(dirname $0)
SHELLNIX="${INSTDIR}/shell.nix"
SHELLDEST="${PWD}/shell.nix"
cp $SHELLNIX $SHELLDEST
sed -i "s/hackstarter/$1/g" shell.nix
cabal2nix $1.cabal --sha256=0 > default.nix
sed -i 's/sha256 = "0"/src=.\/./g' default.nix
