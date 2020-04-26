.PHONY: docker python

REQS := python/requirements.txt
REQS_TEST := python/requirements.txt

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
ifneq (,$(wildcard ./hacker_cookbook_old.pdf))
	rm hacker_cookbook_old.pdf
endif
ifneq (,$(wildcard ./hacker_cookbook.pdf))
	mv hacker_cookbook.pdf hacker_cookbook_old.pdf
endif
ifneq (,$(wildcard ${BUILD_DIR}.old))
endif
ifneq (,$(wildcard ${BUILD_DIR}))
	mv ${BUILD_DIR} ${BUILD_DIR}.old
endif
	/usr/local/bin/python3 makebook/makebook.py
	makebook/makebook2.sh

clean: ## clean up the book build
	@echo "\033[1;32mRenaming stale build dir and backing up last build.\033[0m"
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

docker: ## test application locally
	$(MAKE) print-status MSG="Building with docker-compose"
	@if [ -f /.dockerenv ]; then echo "Don't run make docker inside docker container" && exit 1; fi
	docker-compose -f docker/docker-compose.yml build hacker_cookbook
	@docker-compose -f docker/docker-compose.yml run hacker_cookbook /bin/bash

lint: ## check the Markdown files for issues
	if [ ! `command -v mdl` ]; then \
		echo "gem: --no-document" >> ~/.gemrc;\
		echo "gem: --no-document" >> ~/.gemrc;\
		gem install mdl;\
	fi
	find ./hacker_cookbook/templates -name '*.md' | xargs /usr/local/bin/mdl

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

python: ## setup python stuff
	if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make python inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Set up the Python environment"
	if [ -f '$(REQS)' ]; then python -m pip install -r$(REQS); fi

sphinx: python ## Generate Sphinx cookbook
	$(MAKE) print-status MSG="Building cookbook with Sphinx"
	#sphinx-quickstart
	cd recipes && make html

test: python ## run tests in container
	@if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make test inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Testing"
	if [ -f '$(REQS_TEST)' ]; then python -m pip install -r$(REQS_TEST); fi
