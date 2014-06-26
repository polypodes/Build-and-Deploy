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
	@echo "\tTo build front-end: make integration"
	@echo

dropDb:
	@echo
	@echo "Drop database..."
	@php app/console doctrine:database:drop --force

createDb:
	@echo
	@echo "Create database..."
	@php app/console doctrine:database:create
	@php app/console doctrine:schema:update --force

updateDb:
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

gitPull:
	@git pull origin master
	@composer install --optimize-autoloader

buildAssets:
	@php app/console assets:install --symlink

explainDeploy:
	@echo "git pull origin master + update db schema + build integration + copy new assets + rebuild prod cache"
	@echo "Note you can change the git remote repo username in .git/config"

done:
	@echo
	@echo "Done."

# Tasks sets:

install: createDb clear done
reinstall: dropDb install
deploy: explainDeploy gitPull buildAssets updateDb clear done

# vim:ft=make
