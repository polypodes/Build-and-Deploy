#! /bin/bash

#
# checkDrupalHost.sh
# Copyright (C) 2015 Ronan Guilloux <ronan.guilloux@gmail.com>
#
# Distributed under terms of the MIT license.

# Colors
YELLOW 		= $(shell tput bold ; tput setaf 3)
GREEN 		= $(shell tput bold ; tput setaf 2)
RESETC 		= $(shell tput sgr0)


all: intro tasks conclude
tasks : date php mysql apache utils

help:
	@echo
	@echo "${GREEN}Makefile-based Drupal prerequisites check help message:${RESETC}"
	@echo "Source, authors, copyright: https://github.com/polypodes/Collaborate"
	@echo "\n${YELLOW}Common, global tasks:${RESETC}"
	@echo "\tmake help\t\tshow this help message"
	@echo "\tmake\t\t\tperform a global system check against Drupal requirements"
	@echo "\n${YELLOW}Other tasks:${RESETC}"
	@echo "\tmake date\t\tperform system date & timezone checks."
	@echo "\tmake php\t\tperform php-related checks."
	@echo "\tmake mysql\t\tperform mysql-related checks."
	@echo "\tmake apache\t\tperform apache2-related checks."
	@echo "\tmake utils\t\tperform utils tools-related checks: imagemagick, vim, curl, etc."
	@echo "\n\tAll checks are read-only operations"
	@echo


intro:
	@echo
	@echo "${GREEN}Checking this server against Drupal 7 requirements...${RESETC}"

conclude:
	@echo
	@echo "${GREEN}Done.${RESETC}"
	@echo

date:
	@echo
	@echo "${YELLOW}Server date must be local (ex: CET, etc.):${RESETC}"
	@date

php:
	@echo "${YELLOW} ${RESETC}"
	@echo "${YELLOW}error_reporting set to E_ALL & ~E_NOTICE. Work is ongoing to change this to E_ALL for Drupal 6 and Drupal 7.${RESETC}"
	@php -i | grep error_reporting
	@echo
	@echo "${YELLOW}safe_mode: off. Safe mode may interfere with file and image uploads. This is applicable for only for PHP version's below 5.3.0, as of PHP 5.4.0 Safe Mode has been removed${RESETC}"
	@php -i | grep 'safe_mode'
	@echo
	@echo "${YELLOW}Tokenizer functions require the tokenizer extension to be enabled${RESETC}"
	@php -i | grep 'tokenizer'
	@echo
	@echo "${YELLOW}Recommended PHP configuration settings:${RESETC}"
	@echo
	@echo "${YELLOW}Setting: session.cache_limiter = nocache${RESETC}"
	@php -i | grep 'session.cache_limiter'
	@echo
	@echo "${YELLOW}Setting: session.auto_start = 0${RESETC}"
	@php -i | grep 'session.auto_start'
	@echo
	@echo "${YELLOW}Setting: expose_php = off - Reason: Shows current PHP version in all header requests, security disclosure${RESETC}"
	@php -i | grep 'expose_php'
	@echo
	@echo "${YELLOW}Setting: allow_url_fopen = off - Reason: This is a security issue${RESETC}"
	@php -i | grep 'allow_url_fopen'
	@echo
	@echo "${YELLOW}Setting: magic_quotes_gpc = off - Reason: Forces quotes in variables - This feature has been deprecated as of PHP 5.3.0 and removed as of PHP 5.4.0${RESETC}"
#	@php -i | grep 'magic_quotes_gpc'
	@echo
	@echo "${YELLOW}Setting: register_globals = off - Reason: Security issue - having this enabled subjects PHP variables to input from any source: This feature has been deprecated as of PHP 5.3.0 and removed as of PHP 5.4.0${RESETC}"
#	@php -i | grep 'register_globals'
	@echo
	@echo "${YELLOW}Setting: display_errors = Off - Reason: Hides errors output to display (website) we want to send to log file instead${RESETC}"
	@php -i | grep 'display_errors'
	@echo
	@echo "${YELLOW}Drupal 7 core requires 32MB${RESETC}"
	@php -i | grep 'memory'
	@echo
	@echo "${YELLOW}mysqli extension required${RESETC}"
	@php -m | grep 'mysqli'
	@echo
	@echo "${YELLOW}xml extension required${RESETC}"
	@php -m | grep 'xml'
	@echo
	@echo "${YELLOW}gd extension required & GD Apache2 mode required${RESETC}"
	@php -m | grep 'gd'
	@ls /etc/php5/apache2/conf.d/ | grep 'gd'
	@echo
	@echo "${YELLOW}JSON extension required${RESETC}"
	@php -m | grep 'json'
	@echo
	@echo "${YELLOW}Hash extension required${RESETC}"
	@php -m | grep 'hash'
	@echo
	@echo "${YELLOW}Fileinfo extension required${RESETC}"
	@php -m | grep 'fileinfo'
	@echo
	@echo "${YELLOW}PDO extension required${RESETC}"
	@php -m | grep 'pdo'
	@echo
	@echo "${YELLOW}Drupal 7 may require the time parameter (max_execution_time) to be at least 30 seconds${RESETC}"
	@php -i | grep 'max_execution_time'
	@echo
	@echo "${YELLOW}APC installation guides sometimes recommend setting apc.include_once_override=1. Although this setting does not appear to affect Drupal 6, it causes Drupal 7 to fail ${RESETC}"
#	@php -i | grep 'apc'
	@echo
	@echo "${YELLOW}Timezone must be set${RESETC}"
	@php -i | grep 'date.timezone'
	@echo

mysql:
	@echo "${YELLOW}MySQL:${RESETC}"
	@mysql -V
	@echo

apache:
	@echo "${YELLOW}Apache2:${RESETC}"
	@apache2 -l
	@apache2 -V
	@apache2ctl -M
	@apache2ctl -S
	@echo

utils:
	@echo "${YELLOW}CLI tools${RESETC}"
	@which vim
	@which git
	@which rsync
	@which curl
	@which convert #ImageMagick
	@which tig
	@which tree
	@which ack-grep
	@which lynx


.PHONY: intro conclude tasks help
.PHONY: date php mysql apache utils
