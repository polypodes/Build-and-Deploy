#
# Makefile
# lespolypodes, 2014-06-25 12:44
#

RELEASES := releases
NOW := $(shell date +%Y-%m-%d--%H-%M-%S)
CURRENT := $(RELEASES)/$(NOW)

all: help

release: prepare pull

prepare:
	@test -d $(CURRENT) || mkdir -p $(CURRENT)

update: pull clear

pull:
	@echo "Updating sources using Git..."
	@cd $(CURRENT)
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
	@echo "\tTo update:\tmake update"
	@echo "\tTo clear cache:\tmake clear"
	@echo

# vim:ft=make
#
