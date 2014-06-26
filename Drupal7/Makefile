#
# Makefile
# lespolypodes, 2014-06-25 12:44
#

all:
	@echo "Use Make help."

update: pull clear

pull:
	@echo "Updating sources using Git..."
	@git pull origin prod
	@echo "Done."

clear:
	@echo "Clearing caches using drush..."
	@drush cc all
	@echo "Done."

help:
	@echo
	@echo "Available tasks:"
	@echo
	@echo "\tTo update: make update"
	@echo "\tTo clear cache: make clear"
	@echo

# vim:ft=make
#
