BUILD
=====

Your collegues need to be confortable with your dev environment:

```bash
me@laptop$~: make
me@laptop$~: make install
```

=> a [Makefile to build](build/) PHP, Composer-based web apps


DEPLOY
======

Your sysadmins will probably appreciate this:

```bash
me@server$~: make release
```

=> a [Makefile to deploy](/deploy) web apps on a released-based dirs structure


REASONS
=======

This 'Build & Deploy' Makefile-based initiative is 100% aimed at helping devOps habits grow.

- we need to keep the environment build/deployement simple & fast ;
- nobody want to learn a new [Composer/Grunt/Bower/Npm/Rake/Whatever] tool each time they (re-) build your project ;
- adding a new tool (Gulp?) is very OK, but we don't want to change the habits & feeling other people already know: build/deployement command doesn't change, it's just `make`, as always.

Simple philosophy
=================

- use good old `make`, available on every *NIX platform: GNU/Linux, FreeBSD, Mac OS X.
- it's readable, reliable & very hack-friendly ;
- add/remove/change your rulesets & tools hunder the hood, without binding others to learn how to use it ;  
- While releasing a new version, rollbacking is as simple as deploying: `make rollback` ;
- backup existing assets/data before any release shipping ;
- in case of doubt: `make help`

### Related

- [An introduction to GNU Make](http://www.gnu.org/software/make/manual/make.html#Introduction)

### LICENSE

MIT
