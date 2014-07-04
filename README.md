Deploy
======

Deployers: Shell scripts &amp; Makefiles to deploy web apps on a released-based dirs structure


## Deployment made simple

```bash
me@myserver$~: make release

```

And it's done.

### Classic workflow: release / scream / rollback / breath...

Working with your 'current' remain simple:

```bash
me@myserver$~: make update
me@myserver$~: make check
me@myserver$~: make rollback
```

Now everyone in your team can deploy. And rollback.

### Simple directories structure

```bash
➜  myServer  tree
.
├── [me           2237]  Makefile
├── [me             55]  current -> releases/2014-07-04--16-23-10
├── [me             55]  old -> releases/2014-07-01--11-10-50
├── [me            170]  releases
└── [me            170]  uploads
➜  myServer
```

### Releases sharing a common `uploads` directory

```bash
➜  myServer  tree releases
.
├── [me            170]  releases
    ├── [me            340]  2014-07-01--11-10-50                <-- "old"
    ├── [me            340]  2014-06-21--13-21-27
    ├── [me            340]  2014-05-13--18-34-42
    ├── [me            340]  2014-05-02--14-25-51
    └── [me            340]  2014-07-04--16-23-10                <-- "current"
        ├── [me            68]  src
        └── [me           136]  web
            └── [me          1289]  index.php
            └── [me            16]  uploads -> ../../../uploads  <-- (shared)
➜  myServer
```

### Simple philosophy

- Keep the deployement simple & fast.
- Use Make, available on UNIX / GNU Linux / FreeBSD / Mac OS X
- Change your rules & tools, freely without changing your deployement command: just `make deploy`
- Rollbacking is as simple as deploying: `make rollback`
- In case of doubt: `make help`

### Related

- [An introduction to GNU Make](http://www.gnu.org/software/make/manual/make.html#Introduction)

### LICENSE

MIT
