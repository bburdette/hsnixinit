#
#  assuming there is a myproject.cabal file in the myproject directory,
#  and hsnixinit is checked out into ~, then call this script like so:
#
#  [nixuser@nixsys myproject]$ ~/hsnixinit/setup.sh myproject
#
#  this should create a default.nix and shell.nix.
#  nix-shell should then pull in the dependencies if they are in your nixpkgs.
#
#  You can add a nixpkgs parameter and the script will make a 'ns' script so you 
#  don't have to type "nix-shell -I nixpkgs=~/mynixpkgs" every time.
#
#  for example: 
#  [nixuser@nixsys myproject]$ ~/hsnixinit/setup.sh myproject ~/nixpkgs14.04
#  will make a 'ns' script that contains: 
#      "nix-shell -I nixpkgs=home/username/nixpkgs14.04"
#
#
#
INSTDIR=$(dirname $0)
SHELLNIX="${INSTDIR}/shell.nix"
SHELLDEST="${PWD}/shell.nix"
cp $SHELLNIX $SHELLDEST
sed -i "s/hackstarter/$1/g" shell.nix
cabal2nix $1.cabal --sha256=0 > default.nix
sed -i 's/sha256 = "0"/src=.\/./g' default.nix

if [ "$#" -gt "1" ]
  then 
    echo "nix-shell -I nixpkgs=$2" > ns
    chmod +x ns
  else
    echo "nix-shell" > ns
    chmod +x ns
fi
