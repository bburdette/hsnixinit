Automated setup of haskell projects, based on/inpired by [this blog post](http://wiki.ocharles.org.uk/Nix#how-do-i-use-cabal2nix-for-local-projects).

There are two scripts in this project:  setup.sh and addib.sh.  

setup.sh
=========

setup.sh is a script to create shell.nix, default.nix, and an 'ns' script on nixos for a haskell project.  Then, you can use nix-shell or 'ns' to pull in the dependencies the project needs to build.  

To use, first git clone into a directory someplace:

$ cd ~  
$ git clone https://github.com/bburdette/hsnixinit

The script depends on cabal2nix, so install that.

$ nix-env -i cabal2nix

assuming myhaskellproj contains a cabal file named myhaskellproj.cabal:

$ cd ~/code/myhaskellproj/  
$ ~/hsnixinit/setup.sh myhaskellproj

or 

$ ~/hsnixinit/setup.sh myhaskellproj ~/mynixpkgs

if you have checked out nixpkgs someplace.   

This should create default.nix, shell.nix, and the ns script.  To pull in the dependencies for the project:

$ ./ns

One caveat.  As of this writing the shell.nix included here does not work on nixos 14.04.  However it does work if you check out the newest 14.04 nixpkgs with git and use that.  It works on unstable or newer as well.   

If the ns script ran successfully, you should now have a command prompt like this:

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

The second is the 'cabal name', which you'd use in your .cabal file.  

The third argument is the directory of your nixpkgs git clone.  

What it does:
 - makes a directory for the lib in the appropriate location in nixpkgs.
 - calls cabal2nix to create a default.nix in that directory
 - adds a line in <nixpkgs>/pkgs/top-level/haskell-packages.nix for the lib.

It looks like haskell-packages.nix is for the most part kept in alphabetical order.  This script doesn't maintain that order, it just puts the new lines at the beginning of the section.  You probably should put the new lines in the right place in the file before checking in your changes.  

