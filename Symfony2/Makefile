#
# sf2 Makefile v1.1
# ronan, 2014-08-065 15:30
#

vendor/autoload.php:
	composer install --optimize-autoloader

.PHONY: help
help:
	@echo
	@echo "Available tasks:"
	@echo
	@echo "\tTo install: make install"
	@echo "\tTo reinstall: make reinstall"
	@echo "\tTo deploy: make deploy"
	@echo "\tTo clear all caches: make clear"
	@echo "\tTo run tests: make tests"
	@echo

.PHONY: pull
pull:
	@git pull origin master
	@composer install --optimize-autoloader

.PHONY: integration
integration:
	@echo
	@cd integration
	@gulp build
	@cd ../

.PHONY: dropDb
dropDb:
	@echo
	@echo "Drop database..."
	@php app/console doctrine:database:drop --force

.PHONY: createDb
createDb:
	@echo
	@echo "Create database..."
	@php app/console doctrine:database:create
	@php app/console doctrine:schema:update --force

.PHONY: schemaDb
schemaDb:
	@echo
	@echo "Configure database schema..."
	@php app/console doctrine:schema:update --force

.PHONY: assets
assets:
    @echo "\nPublishing assets..."
	@php app/console assets:install --symlink

.PHONY: clear
clear:
	@echo
	@echo "Resetting caches..."
	@php app/console cache:clear --env=prod --no-debug
	@php app/console cache:clear --env=dev

data:
	@echo "Install initial datas..."
	@./console dbal:data:initialize --purge
	
fixtures:
	@echo "Install fixtures in db..."
	@./console dbal:fixtures:load --purge

assets:
	@php app/console assets:install --symlink

explain:
	@echo "git pull origin master + update db schema + build integration + copy new assets + rebuild prod cache"
	@echo "Note you can change the git remote repo username in .git/config"

.PHONY: behavior
behavior:
	@echo "Run behavior tests..."
	bin/behat --lang=fr  "@AcmeDemoBundle"

.PHONY: unit
unit:
	@echo "Run unit tests..."
	@php bin/phpunit -c build/phpunit.xml -v

.PHONY: codecoverage
codecoverage:
	@echo "Run coverage tests..."
	@bin/phpunit -c build/phpunit.xml -v --coverage-html ./build/codecoverage

.PHONY: continuous
continuous:
	@echo "Starting continuous tests..."
	@while true; do bin/phpunit -c build/phpunit.xml -v; done

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

done:
	@echo
	@echo "Done."

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
