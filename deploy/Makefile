#
# Makefile
# Les Polypodes, 2014-06-25 12:44
# Licence: MIT
# Source: https://github.com/polypodes/Deploy/blob/master/Drupal7/Makefile

# Usage:

# me@myserver$~: make help
# me@myserver$~: make release
# me@myserver$~: make rollback
# me@myserver$~: make update
# me@myserver$~: make check
# etc.



############################################################################
# Vars

PWD := $(shell pwd)
RELEASES := $(PWD)/releases
CURRENT := $(PWD)/current
OLD := $(PWD)/old
NOW := $(shell date +%Y-%m-%d--%H-%M-%S)
NEW := $(RELEASES)/NEW
REPO := "https://github.com/polypodes/Deploy.git"
BRANCH := 'master'
# Linux user & group
WWWUSER := myLinuxUser
WWWGROUP := myLinuxGroup
# Colors
YELLOW := $(shell tput bold ; tput setaf 3)
GREEN := $(shell tput bold ; tput setaf 2)
RESETC := $(shell tput sgr0)

all: check help

############################################################################
# Specific tasks:

check:
	@test -d $(RELEASES) || mkdir -p $(RELEASES)

permissions:
	@chmod -R 775 $(CURRENT)
	@chown -R $(WWWUSER):$(WWWGROUP) $(CURRENT)
	
create:
    @echo "Create new release, for the first import of the project"
    @mv $(NEW) $(RELEASES)/$(NOW)
    @ln -s $(RELEASES)/$(NOW) $(CURRENT)

switch:
	@echo "Switching actual 'current' & 'old' symlinks using the new release..."
	@rm $(OLD);
	@mv $(CURRENT) $(OLD);
	@mv $(NEW) $(RELEASES)/$(NOW)
	@ln -s $(RELEASES)/$(NOW) $(CURRENT)
	@cp $(OLD)/sites/default/settings.php $(CURRENT)/sites/default/settings.php
	@cp -R $(OLD)/sites/default/files/* $(CURRENT)/sites/default/files/

rollback:
	@mv $(CURRENT) rollbacked
	@mv $(OLD) $(CURRENT)

clear:
	@echo "Clearing caches using drush..."
#	@drush cc all

done:
	@echo
	@ls -la
	@echo "${GREEN}Done.${RESETC}"
	@echo

help:
	@echo
	@echo "${GREEN}Usual tasks:${RESETC}"
	@echo
	@echo "\t* (clone) create the first release:\t\t\t${YELLOW}make origine{RESETC}"
	@echo "\t* (clone) create a new release:\t\t\t${YELLOW}make release${RESETC}"
	@echo "\t* (pull) update the current release:\t\t${YELLOW}make update${RESETC}"
	@echo
	@echo "${GREEN}Other specific tasks:${RESETC}"
	@echo
	@echo "\t* (mkdir) check dirs structure:\t\t\t${YELLOW}make check${RESETC}"
	@echo "\t* (rm) clear cache:\t\t\t\t${YELLOW}make clear${RESETC}"
	@echo "\t* (chown+chmod) set up files/dirs permissions:\t${YELLOW}make permissions${RESETC}"
	@echo "\t* (mv) rollback to the previous/old release:\t${YELLOW}make switch${RESETC}"
	@echo

############################################################################
# Usual tasks:

origin: check
    @echo "git-cloning sources using ${GREEN}$(BRANCH)${RESETC} branch..."
    @git clone -b $(BRANCH) $(REPO) $(NEW)
    @cd $(NEW) && git config core.filemode false && cd $(PWD)
    @$(MAKE) create
    @$(MAKE) clear
    @$(MAKE) done

release: check
	@echo "git-cloning sources using ${GREEN}$(BRANCH)${RESETC} branch..."
	@git clone -b $(BRANCH) $(REPO) $(NEW)
	@cd $(NEW) && git config core.filemode false && cd $(PWD)
	@$(MAKE) switch
	@$(MAKE) clear
	@$(MAKE) done

update: check
	@echo "git-pulling sources using $(BRANCH) branch..."
	@cd $(CURRENT) && git pull origin $(BRANCH) && cd $(PWD)
	@$(MAKE) clear
	@$(MAKE) done


.PHONY: all check permissions switch rollback clear done hellp release update
# vim:ft=make
#
