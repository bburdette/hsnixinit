hsnixinit
=========

script to create nix files on nixos for a haskell project.  

first clone into a directory someplace:

$ cd ~  
$ git clone https://github.com/bburdette/hsnixinit#  

depends on cabal2nix:

$ nix-env -i cabal2nix

assuming myhaskellproj contains a cabal file named myhaskellproj.cabal:

$ cd ~/code/myhaskellproj/  
$ ~/hsnixinit/setup.sh myhaskellproj

this creates default.nix and shell.nix.  

if you're on nixos 14.04, this won't work.  But on unstable it should work ok:
$ nix-shell  

on my system I have nixpkgs checked out into ~/nixpkgs.  I can do this:

$ nix-shell -I nixpkgs=~/nixpkgs

be warned that this involves a great deal of compilation!  
now I can build my project:

$ cabal sandbox init  
$ cabal install

and maybe make a link for convenience:

$ ln .cabal-sandbox/bin/myhaskellproj myhaskellproj

and execute the program:

$ ./myhaskellproj
