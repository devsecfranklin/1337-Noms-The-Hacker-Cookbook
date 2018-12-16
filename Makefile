.PHONY: book lint

REQS := requirements.txt
BUILD_DIR := /tmp/cookbook

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

#RED=$(echo -e '\033[0;31m')
#LRED=$(echo -e '\033[1;31m')
#LGREEN=$(echo -e \033[1;32m')
#CYAN=$(echo -e '\033[0;36m')
#LPURP=$(echo -e '\033[1;35m')
#YELLOW := $(echo -e "\033[1;33m")
#NC := $(echo -e "\033[0m") # No Color

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
  match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
  if match:
    target, help = match.groups()
    print("%-20s %s" % (target, help))
endef

export PRINT_HELP_PYSCRIPT

help: 
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

book:clean ## Generate a PDF copy of the Hacker Cookbook
	@echo "\033[1;33mGenerating PDF cookbook...hang tight!\033[0m"
	book/makebook.sh

clean: ## clean up the book build
	@echo "\033[1;32mRenaming stale build dir and backing up last build.\033[0m"
ifneq (,$(wildcard ./hacker_cookbook_old.pdf))
	rm hacker_cookbook_old.pdf
	mv hacker_cookbook.pdf hacker_cookbook_old.pdf
endif

ifneq (,$(wildcard ${BUILD_DIR}.old))
	rm -rf ${BUILD_DIR}.old
	mv ${BUILD_DIR} ${BUILD_DIR}.old
endif

lint: ## check the Markdown files for issues
	if [ ! command -v mdl ]; then \
		echo "gem: --no-document" >> ~/.gemrc;\
		sudo gem install mdl;\
	fi
	find . -name '*.md' | xargs /usr/local/bin/mdl

#find . -name '*.md' | xargs /var/lib/gems/2.3.0/gems/mdl-0.4.0/bin/mdl
