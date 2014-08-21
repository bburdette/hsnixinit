hsnixinit
=========

script to create shell.nix and default.nix files on nixos for a haskell project, using cabal2nix.  Then, you can use nix-shell to pull in the dependencies the project needs to build.  

To use, first clone into a directory someplace:

$ cd ~  
$ git clone https://github.com/bburdette/hsnixinit#  

The script depends on cabal2nix, so install that.

$ nix-env -i cabal2nix

assuming myhaskellproj contains a cabal file named myhaskellproj.cabal:

$ cd ~/code/myhaskellproj/  
$ ~/hsnixinit/setup.sh myhaskellproj

This should create default.nix and shell.nix.  Now to pull in the dependencies for the project.

If you're on nixos 14.04, the following won't work!  But on unstable it should work ok:
$ nix-shell  

On my nixos 14.04 system I have nixpkgs checked out into ~/nixpkgs.  I can do this:

$ nix-shell -I nixpkgs=~/nixpkgs

be warned that this involves a great deal of compilation!  When all that finishes, I can build the project like so: 

$ cabal sandbox init  
$ cabal install

and maybe make a link for convenience:

$ ln .cabal-sandbox/bin/myhaskellproj myhaskellproj

and execute the program:

$ ./myhaskellproj
