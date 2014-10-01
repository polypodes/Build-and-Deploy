Deployment made simple
======================

This Makefile is 100% _devops_ oriented :


```bash
me@myserver$~: make release

```

And it's done.

### Classic workflow: release / scream / rollback / breath & find out the reason of a crash

- _releasing_ = keeping the current release, renaming it as an "old" one, then creating a new "current" release. In case of crash just after deploying the new release, symlinks come to the rescue !
- _rollbacking_ = Using the "old" release symlink, your website quickly gets back on its feet. 

```bash
me@myserver$~: make release
me@myserver$~: make rollback
```

Now everyone in your team can deploy. And rollback.

### Simple directories structure


```bash
➜  myServer  tree
.
├── [me  2237]  Makefile                         <-- This is where the magic happens.
├── [me    55]  current -> releases/2014-07-04   <-- your Apache2 vhost 'DocRoot'
├── [me    55]  old -> releases/2014-07-01       <-- rollback-able recent release
├── [me   170]  releases                         <-- all releases
└── [me   170]  uploads                          <-- shared, cross-releases folder
➜  myServer
```

### Releases sharing a common `uploads` directory

```bash
➜  myServer  tree releases
.
└── [me            170]  releases
    ├── [me            340]  2014-07-01--11-10-50                <-- "old"
    ├── [me            340]  2014-06-21--13-21-27
    ├── [me            340]  2014-05-13--18-34-42
    ├── [me            340]  2014-05-02--14-25-51
    └── [me            340]  2014-07-04--16-23-10                <-- "current"
        ├── [me            68]  src
        └── [me           136]  web
            └── [me          1289]  index.php
            └── [me            16]  uploads -> ../../../uploads  <-- a symlink
            
➜  myServer
```
