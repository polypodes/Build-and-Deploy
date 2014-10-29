#
# Makefile
# Les Polypodes, 2014-06-25 12:44
# Licence: MIT
# Source: https://github.com/polypodes/Build-and-Deploy/blob/master/deploy/Makefile

# Usage:
#
# 	make help
# 	make init
# 	make release
# 	make rollback
# 	make update
# 	make check

############################################################################
# Vars

PWD         := $(shell pwd)
RELEASES    := $(PWD)/releases
CURRENT     := $(PWD)/current
WEB         := $(PWD)/current/web
OLD         := $(PWD)/old
NOW         := $(shell date +%Y-%m-%d--%H-%M-%S)
NEW         := $(RELEASES)/NEW
REPO        := "https://github.com/polypodes/Deploy.git"
BRANCH      := 'master'
DB_USER	    := $(shell if [ -f app/config/parameters.yml ] ; then cat app/config/parameters.yml | grep 'database_user' | sed 's/database_user: //' | sed 's/^ *//;s/ *$$//' ; fi)
DB_PASSWORD := $(shell if [ -f app/config/parameters.yml ] ; then cat app/config/parameters.yml | grep 'database_password' | sed 's/database_password: //' | sed 's/null//' | sed 's/^ *//;s/ *$$//' ; fi)
DB_NAME     := $(shell if [ -f app/config/parameters.yml ] ; then cat app/config/parameters.yml | grep 'database_name' | sed 's/database_name: //' | sed 's/^ *//;s/ *$$//' ; fi)

# Linux user & group
WWWUSER     := myLinuxUser
WWWGROUP    := myLinuxGroup

# Colors
YELLOW      := $(shell tput bold ; tput setaf 3)
GREEN       := $(shell tput bold ; tput setaf 2)
RESETC      := $(shell tput sgr0)

# `make`command will run this default task set:
all: check help

############################################################################
# Specific tasks:

check:
	@test -d $(RELEASES) || mkdir -p $(RELEASES)

permissions:
	@chmod -R 775 $(CURRENT)
	@chown -R $(WWWUSER):$(WWWGROUP) $(CURRENT)
	
create:
	@echo "Creating the very first release"
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

robot:
	@echo "User-agent: *" > $(WEB)/robots.txt
	@echo "Disallow: " >> $(WEB)/robots.txt

unrobot:
	@echo "User-agent: *" > $(WEB)/robots.txt
	@echo "Disallow: /" >> $(WEB)/robots.txt

dumps:
	@echo "Creating dump folder for SQL exports..."
	@mkdir ./dumps

mysqldump: dumps
	@echo "dumping existing db into ./dumps ..."
	@mysqldump --user=${DB_USER} --password=${DB_PASSWORD} ${DB_NAME} > dumps/${NOW}.sql 2>/dev/null

done:
	@echo
	@ls -la
	@echo "${GREEN}Done.${RESETC}"
	@echo

help:
	@echo
	@echo "${GREEN}Usual tasks:${RESETC}"
	@echo
	@echo "\t* (clone) create the initial release:\t\t${YELLOW}make init${RESETC}"
	@echo "\t* (clone) add a new, up-to-date release:\t${YELLOW}make release${RESETC}"
	@echo "\t* (pull) update the current release:\t\t${YELLOW}make update${RESETC}"
	@echo
	@echo "${GREEN}Other specific tasks:${RESETC}"
	@echo
	@echo "\t* display this help message:\t\t\t${YELLOW}make help${RESETC}"	
	@echo "\t* (mkdir) check dirs structure:\t\t\t${YELLOW}make check${RESETC}"
	@echo "\t* (rm) clear cache:\t\t\t\t${YELLOW}make clear${RESETC}"
	@echo "\t* (chown+chmod) set up files/dirs permissions:\t${YELLOW}make permissions${RESETC}"
	@echo "\t* (mv) rollback to the previous/old release:\t${YELLOW}make switch${RESETC}"
	@echo

############################################################################
# Usual tasks:

init: check
	@echo "Git-cloning sources using ${GREEN}$(BRANCH)${RESETC} branch..."
	@git clone -b $(BRANCH) $(REPO) $(NEW)
	@cd $(NEW) && git config core.filemode false && cd $(PWD)
	@$(MAKE) create
	@$(MAKE) clear
	@$(MAKE) done

release: check mysqldump
	@echo "Git-cloning sources using ${GREEN}$(BRANCH)${RESETC} branch..."
	@git clone -b $(BRANCH) $(REPO) $(NEW)
	@cd $(NEW) && git config core.filemode false && cd $(PWD)
	@$(MAKE) switch
	@$(MAKE) clear
	@$(MAKE) done

update: check mysqldump
	@echo "Git-pulling sources using $(BRANCH) branch..."
	@cd $(CURRENT) && git pull origin $(BRANCH) && cd $(PWD)
	@$(MAKE) clear
	@$(MAKE) done


.PHONY: all check permissions switch rollback clear done
.PHONY: help init release update robot unrobot mysqldump
# vim:ft=make
#
