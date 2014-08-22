There are two scripts in this project:  setup.sh and addib.sh.  

setup.sh
=========

setup.sh is a script to create shell.nix and default.nix files on nixos for a haskell project, using cabal2nix.  Then, you can use nix-shell to pull in the dependencies the project needs to build.  

To use, first clone into a directory someplace:

$ cd ~  
$ git clone https://github.com/bburdette/hsnixinit

The script depends on cabal2nix, so install that.

$ nix-env -i cabal2nix

assuming myhaskellproj contains a cabal file named myhaskellproj.cabal:

$ cd ~/code/myhaskellproj/  
$ ~/hsnixinit/setup.sh myhaskellproj

This should create default.nix and shell.nix.  Now to pull in the dependencies for the project.

The shell.nix included here does not work on nixos 14.04 by default.  But on my nixos 14.04 system I have a newer copy of nixpkgs checked out into ~/nixpkgs.  I can do this:

$ nix-shell -I nixpkgs=~/nixpkgs

That's a capital 'I' as in Internets.  Be warned that this approach (a checkout of nixpkgs) involves a great deal of compilation!  Seriously, a lot.  I'm using a checkout of nixpkgs because I wanted to add some dependencies to it.  See here:  https://github.com/bburdette/nixpkgs.  

I'm told that on the nixos 'unstable' channel this should work by downloading pre-built binaries:

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

addlib.sh
=========

Add a haskell library to your local nixpkgs checkout, like this:

$ ./addlib.sh nonEmpty non-empty ~/nixpkgs

The first argument is the 'import name' of the library, ie in your haskell file you'd say 
import nonEmpty

The second is the 'cabal name', which you'd use in you .cabal file.  

The third argument is the directory of your nixpkgs git clone.  

What it does:
 - makes a directory for the lib in the appropriate location in nixpkgs.
 - calls cabal2nix to create a default.nix in that directory
 - adds a line in <nixpkgs>/pkgs/top-level/haskell-packages.nix for the lib.

