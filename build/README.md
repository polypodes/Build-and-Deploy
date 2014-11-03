# BUILDING made simple


```bash
me@laptop$~: make
me@laptop$~: make install
```

And it's done.

## Building the app using good old Makefile


Building apps may be traumatic for someone, in particular if your team does not feel comfortable with server-side apps. 

The main purpose of this makefile is to drastically simplify the "building the app" experience of your webdesigner or other non-developper colleagues. Two simple commands is enough to see your app running locally on their machine.

In addition to these two fondamental commands, a Makefile-based build process allow you to add many other tasks defined to help developers to build/rebuild their (Symfony2-based) web app easely, combining various mandatory operations, such as adding fake fixtures data, run behavior/functional/unit tests, lint & checkstyle the code source, etc.

Makefile is a damn simple 1977 technology coming from C language developers toolbelt. Often imitated
(Gulp, Grunt, Ant, Rake, Jake, Phake, etc.) but never equalled for configuring simple repetitive filesytem-centric task sets.

To install an app locally, just configure the vars (git repo, etc.) then run first:

```bash
me@myserver$~: make
```

This creates the mandatory folder structure (folders being ignored in your .gititgnore), check your app requirements againts the operating system, install your dependencies (cf. [composer](http://getcomposer.org) that create the `vendor/autoload.php` file) etc.  

and then

```bash
make install
```

This creates the database, its schema, add the basics data required by your application, etc.


## No commit without a little quality check

If your source code is versioned using Git, this Makefile proposes an on-the-fly source code check attached to the git pre-commit action: it's called a _hook_, and it's [Git native magic](http://git-scm.com/book/en/Customizing-Git-Git-Hooks):

```
.git/hook/pre-commit:
   	curl -o .git/hooks/pre-commit https://raw.githubusercontent.com/polypodes/Build-and-Deploy/master/hooks/pre-commit
   	chmod +x .git/hooks/pre-commit
```

Now each `git commit` command will first run this little shell script (now copied in your `git/hooks` dir) that will check your source code and deny/reject any commit attempd if your code remains ugly. You can easily add more check processes to this.

Someone calls it 'quality facism'. Deal with it.


## Some useful Make tasks you'll love

- `make sniff/dry-fix` run a linter & a _dry_ check-style operation over the `./src` source code files (no changes)

- `make quality` is a shortcut to run `sniff`+ `dry-fix` quality tests suites over source code ub `./src/`. It's a "silent" task when ran successfully,
since a git pre-commit hook uses it to check if commit can be accepted.

- `make cs-fix` will _fix_ the code source style, (therefore it _corrects_ it).

- `make unit/behavior/codecoverage` is a shortcut for Behat, PhpUnit & PHPCodeCoverage.

- `make check` run the `app/check.php` Symfony2 internal check (PHP version, I/O permissions, etc.). Usefull to check
if your environment is OK against Symfony2 requirements.

- `make createDb/dropDb/schemaDb` are easy to understand: see `php app/console` doctrine-based operations for more.

- `make assets` and `make clear` build `/web/` assets (JS, CSS, etc.) from your bundle resources (this is Symfony2 regular behavior)
and purge then warm your applciation cache, for your dev/prod environments

- make `stats` is for quality maniacs

- `make deploy` fetches & merges new commits from the main `origin` git repository: it updates source code & db schema,
then it ends with clearing & warming caches. This _may_ be used to grab your colleagues contributions inside the _master_ branch.
This also may be used WITHOUT GUARANTEES in en preprod/prod environments for very small updates (but no fast-rollback is possible).

To enable this quality-related tasks, add these dependencies to your `composer.json`: they'll be available in the `./bin` dir :

```json
    "require-dev": {
        "phpunit/phpunit":                          "~3.7",
        "squizlabs/php_codesniffer":                "2.0.x-dev",
        "sebastian/phpcpd":                         "*",
        "phploc/phploc" :                           "*",
        "phpmd/phpmd" :                             "2.0.*",
        "pdepend/pdepend" :                         "2.0.*",
        "fabpot/php-cs-fixer":                      "@stable"
    }
```


