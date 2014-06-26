#
# Makefile
# ronan, 2014-03-05 10:40
#

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

drop:
	@echo
	@echo "Drop database..."
	@php app/console doctrine:database:drop --force

db:
	@echo
	@echo "Create database..."
	@php app/console doctrine:database:create

schema:
	@echo
	@echo "Update database..."
	@php app/console doctrine:schema:update --force

clear:
	@echo
	@echo "Resetting cache..."
	@php app/console cache:clear --env=prod --no-debug
	@php app/console cache:clear --env=dev

integration:
	@echo
	@cd integration
	@gulp build
	@cd ../

pull:
	@git pull origin master
	@composer install --optimize-autoloader

data:
	@echo "Install initial datas..."
	@./console dbal:data:initialize --purge
	
assets:
	@php app/console assets:install --symlink

explain:
	@echo "git pull origin master + update db schema + build integration + copy new assets + rebuild prod cache"
	@echo "Note you can change the git remote repo username in .git/config"
	
fixtures:
	@echo "Install fixtures in db..."
	@./console dbal:fixtures:load --purge

behaviour:
	@echo "Run behaviour tests"
	bin/behat --lang=fr  "@MyAppMyBundle"
	phpunit

unit:
	@echo "Run unit tests"
	@php ./phpunit -c build/phpunit.xml -v

codecoverage:
	@echo "Run coverage tests"
	@./phpunit -c build/phpunit.xml -v --coverage-html ./build/codecoverage

continuous:
	@echo "Starting continuous integration..."
	@while true; do ./phpunit -c build/phpunit.xml -v; done

check:
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

install: pull db schema data assets clear done
reinstall: drop install
tests: reinstall fixtures behaviour unit
deploy: explain install done

# vim:ft=make
