hsnixinit
=========

script to create shell.nix and default.nix files on nixos for a haskell project, using cabal2nix.  Then, you can use nix-shell to pull in the dependencies the project needs to build.  

To use, first clone into a directory someplace:

$ cd ~  
$ git clone https://github.com/bburdette/hsnixinit

The script depends on cabal2nix, so install that.

$ nix-env -i cabal2nix

assuming myhaskellproj contains a cabal file named myhaskellproj.cabal:

$ cd ~/code/myhaskellproj/  
$ ~/hsnixinit/setup.sh myhaskellproj

This should create default.nix and shell.nix.  Now to pull in the dependencies for the project.

On my nixos 14.04 system I have nixpkgs checked out into ~/nixpkgs.  I can do this:

$ nix-shell -I nixpkgs=~/nixpkgs

be warned that this involves a great deal of compilation!  Seriously, a lot.  I'm told that on nixos unstable this should work:

$ nix-shell  

If the nix-shell command ran successfully, you should now have a command prompt like this:

[nix-shell:~/code/myhaskellproject]$

Now build the project:

[nix-shell:~/code/myhaskellproject]$ cabal sandbox init  
[nix-shell:~/code/myhaskellproject]$ cabal install

and maybe make a link for convenience:

[nix-shell:~/code/myhaskellproject]$ ln .cabal-sandbox/bin/myhaskellproj myhaskellproj

and execute the program:

[nix-shell:~/code/myhaskellproject]$ ./myhaskellproj
