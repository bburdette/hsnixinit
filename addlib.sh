# $1 = library name, ie import <libname>
# $2 = cabal package name, ie its name in .cabal file
# $3 = nixpkgs location, no trailing /.
#
# example:
#   $ ~/hsnixinit/addlib.sh webRoutesHappstack web-routes-happstack ~/nixpkgs14.04
#
SHELLNIX="${INSTDIR}/shell.nix"
LIBDIR="$3/pkgs/development/libraries/haskell/"
PACKNIX="$3/pkgs/top-level/haskell-packages.nix"

# use cabal2nix to create the default.nix for the package.
cd ${LIBDIR}
mkdir "${LIBDIR}$2"
cabal2nix "cabal://$2" > "${LIBDIR}$2/default.nix"

# to do:  read in lines until reaching this one:
  # Haskell libraries.

LINE=$(grep -n "# Haskell libraries." "${PACKNIX}" | grep -o [0-9]*)
LINEPLUS1=$(echo ${LINE} + 1 | bc)

# upto the 'haskell libraries' line.
head -n "${LINEPLUS1}" "${PACKNIX}" > newpack.nix

echo "  $1 = callPackage ../development/libraries/haskell/$2 {}; " >> newpack.nix

# what we're adding in.  should be alphabetical, I guess do that manually before you commit!
LINEPLUS2=$(echo ${LINE} + 2 | bc)
# and the rest of the file.
tail -n "+${LINEPLUS2}" "${PACKNIX}" >> newpack.nix

# write over the hapless haskell package file with our new one.
cp newpack.nix ${PACKNIX}

# e  then build new file by catting lines up to that with this line:
#  acidState = callPackage ../development/libraries/haskell/acid-state {};
# followed by the remaining lines.



# cabal2nix cabal://$1 > default.nix
