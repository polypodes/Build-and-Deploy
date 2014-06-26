#
# Makefile
# ronan, 2014-06-11 17:20
#

help:
	@echo
	@echo "Available tasks:"
	@echo
	@echo -e "\tmake pull \t\tPull changes from remote GIT repo"
	@echo -e "\tmake build \t\tBuild layout & assets changes"
	@echo -e "\tmake deploy\t\tDeploy new changes (fetch+build)"
	@echo

prepare:
	@echo
	@echo "Deploying: Pulling remote changes then re-build website locally"

fetch:
	@git pull origin master

rebuild:
	@echo
	@gulp build

done:
	@echo
	@echo "Done."

# Tasks sets:

deploy: prepare fetch rebuild done

# vim:ft=make
