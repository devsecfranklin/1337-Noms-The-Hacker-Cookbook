.PHONY: book build

REQS := requirements.txt
BUILD_DIR := /tmp/cookbook

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

book: clean ## Generate a PDF copy of the Hacker Cookbook
	@echo "\033[1;33mGenerating PDF cookbook...hang tight!\033[0m"
	makebook/makebook.sh

clean: ## clean up the book build
	@echo "\033[1;32mRenaming stale build dir and backing up last build.\033[0m"
ifneq (,$(wildcard ./hacker_cookbook_old.pdf))
	rm hacker_cookbook_old.pdf
endif
ifneq (,$(wildcard ./hacker_cookbook.pdf))
	mv hacker_cookbook.pdf hacker_cookbook_old.pdf
endif
ifneq (,$(wildcard ${BUILD_DIR}.old))
	rm -rf ${BUILD_DIR}.old
	rm -rf .tox
	rm -rf venv
	rm -rf .pytest_cache
	rm -rf .coverage
	rm -rf *.egg-info
	rm -rf build
	rm -rf dist
	rm -rf htmlcov
	find . -name '*.pyc' | xargs rm -rf
	find . -name '__pycache__' | xargs rm -rf
	
endif
ifneq (,$(wildcard ${BUILD_DIR}))
	mv ${BUILD_DIR} ${BUILD_DIR}.old
endif

lint: ## check the Markdown files for issues
	if [ ! command -v mdl ]; then \
		echo "gem: --no-document" >> ~/.gemrc;\
		sudo gem install mdl;\
	fi
	find . -name '*.md' | xargs /usr/local/bin/mdl

#find . -name '*.md' | xargs /var/lib/gems/2.3.0/gems/mdl-0.4.0/bin/mdl
local-dev: ## test application locally
	python3 -m compileall .
	docker-compose up --build hacker_cookbook
	@docker-compose run hacker_cookbook /bin/bash
