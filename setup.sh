#
#  assuming there is a myproject.cabal file in the myproject directory,
#  and hsnixinit is checked out into ~, then call this script like so:
#
#  [nixuser@nixsys myproject]$ ~/hsnixinit/setup.sh myproject
#
#  this should create a default.nix and shell.nix.
#  nix-shell should then pull in the dependencies if they are in your nixpkgs.
#
INSTDIR=$(dirname $0)
SHELLNIX="${INSTDIR}/shell.nix"
SHELLDEST="${PWD}/shell.nix"
cp $SHELLNIX $SHELLDEST
sed -i "s/hackstarter/$1/g" shell.nix
cabal2nix $1.cabal --sha256=0 > default.nix
sed -i 's/sha256 = "0"/src=.\/./g' default.nix
