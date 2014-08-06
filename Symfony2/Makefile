#
# Makefile
# Les Polypodes, 2014-08-06 15:41
# Licence: MIT
# Source: https://github.com/polypodes/Deploy/blob/master/Symfony2/Makefile

# Usage:

# me@myserver$~: make help
# me@myserver$~: make pull
# me@myserver$~: make install
# me@myserver$~: make sniff
# me@myserver$~: make codecoverage
# etc.



############################################################################
# Vars

PWD := $(shell pwd)
NOW := $(shell date +%Y-%m-%d--%H-%M-%S)
REPO := "https://github.com/..."
BRANCH := 'master'
# Colors
YELLOW := $(shell tput bold ; tput setaf 3)
GREEN := $(shell tput bold ; tput setaf 2)
RESETC := $(shell tput sgr0)


############################################################################
# Mandatory tasks:
vendor/autoload.php:
	composer install --optimize-autoloader

############################################################################
# Specific, project-related sf2 tasks:


.PHONY: integration
integration:
	@echo
	@cd integration
	@gulp build
	@cd ../

.PHONY: data	
data: vendor/autoload.php
	@echo "Install initial datas..."
	@./console dbal:data:initialize --purge

.PHONY: fixtures	
fixtures: vendor/autoload.php
	@echo "Install fixtures in db..."
	@./console dbal:fixtures:load --purge

############################################################################
# Generic sf2 tasks:

.PHONY: help
help:
	@echo
	@echo "${GREEN}Usual tasks:${RESETC}"
	@echo
	@echo "\tTo install: make install"
	@echo "\tTo reinstall: make reinstall"
	
	@echo "${GREEN}Other specific tasks:${RESETC}"
	@echo
	@echo "\tTo deploy: make deploy"
	@echo "\tTo clear all caches: make clear"
	@echo "\tTo run tests: make tests"
	@echo
	
.PHONY: pull
pull:
	@git pull origin $(BRANCH)


.PHONY: dropDb
dropDb: vendor/autoload.php
	@echo
	@echo "Drop database..."
	@php app/console doctrine:database:drop --force

.PHONY: createDb
createDb: vendor/autoload.php
	@echo
	@echo "Create database..."
	@php app/console doctrine:database:create
	@php app/console doctrine:schema:update --force

.PHONY: schemaDb
schemaDb: vendor/autoload.php
	@echo
	@echo "Configure database schema..."
	@php app/console doctrine:schema:update --force

.PHONY: assets
assets:
	@echo "\nPublishing assets..."
	@php app/console assets:install --symlink

.PHONY: clear
clear: vendor/autoload.php
	@echo
	@echo "Resetting caches..."
	@php app/console cache:clear --env=prod --no-debug
	@php app/console cache:clear --env=dev

explain:
	@echo "git pull origin master + update db schema + build integration + copy new assets + rebuild prod cache"
	@echo "Note you can change the git remote repo username in .git/config"

.PHONY: behavior
behavior: vendor/autoload.php
	@echo "Run behavior tests..."
	bin/behat --lang=fr  "@AcmeDemoBundle"

.PHONY: unit
unit: vendor/autoload.php
	@echo "Run unit tests..."
	@php bin/phpunit -c build/phpunit.xml -v

.PHONY: codecoverage
codecoverage: vendor/autoload.php
	@echo "Run coverage tests..."
	@bin/phpunit -c build/phpunit.xml -v --coverage-html ./build/codecoverage

.PHONY: continuous
continuous: vendor/autoload.php
	@echo "Starting continuous tests..."
	@while true; do bin/phpunit -c build/phpunit.xml -v; done

.PHONY: sniff
sniff: vendor/autoload.php
	bin/phpcs --standard=PSR2 src -n


.PHONY: check
check:
	@echo "Starting code check-up..."
	# phploc: https://github.com/sebastianbergmann/phploc
	# phpmd: https://github.com/phpmd/phpmd
	# phpcpd: https://github.com/sebastianbergmann/phpcpd
	# pdepend: https://github.com/pdepend/pdepend
	# php-cs-fixer: https://github.com/fabpot/PHP-CS-Fixer
	@phploc src
	@phpcs --standard=build/phpcs.xml src
	@phpmd src text codesize,unusedcode,naming
	@phpcpd src
	@pdepend src
	@php-cs-fixer fix src --dry-run
	
.PHONY: deploy
deploy: vendor/autoload.php
	@echo "UPDATING using git pull origin $(BRANCH) + update db schema + rebuild prod cache..."
	@echo "Note you can change the git remote repo username in .git/config"
	@git pull origin $(BRANCH)
	@$(MAKE) schemaDb
	@php app/console cache:clear --env=prod --no-debug

done:
	@echo
	@echo "${GREEN}Done.${RESETC}"

# Tasks sets:

.PHONY: prepareDb
prepareDb: createDb schemaDb

.PHONY: purgeDb
purgeDb: dropDb createDb schemaDb

.PHONY: install
install: prepareDb data assets clear done

.PHONY: reinstall
reinstall: dropDb install

.PHONY: tests
tests: reinstall fixtures behavior unit codecoverage

deploy: explain install done

# vim:ft=make
