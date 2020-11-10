.PHONY: docker docs python

REQS := requirements.txt

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

book: python ## Generate documentation
	@if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Run make docs inside docker container <***" && exit 1; fi
	$(MAKE) print-status MSG="Building HTML docs"
	cd recipes && make html && cd -
	$(MAKE) print-status MSG="Building LaTeX docs"
	cd recipes && \
	sphinx-build -b latex -d _build/doctrees . _build/xetex && cd _build/xetex; xelatex *.tex && \
	cd -
	$(MAKE) print-status MSG="Building EPUB docs"
	cd recipes && make epub && cd -

clean: ## clean up the book build
	@echo "\033[1;32mRenaming stale build dir and backing up last build.\033[0m"
	rm -rf ${BUILD_DIR}.old
	rm -rf recipes/_build
	find . -name '*.pyc' | xargs rm -rf
	find . -name '__pycache__' | xargs rm -rf

docker: ## test application locally
	$(MAKE) print-status MSG="Building with docker-compose"
	@if [ -f /.dockerenv ]; then echo "Don't run make docker inside docker container" && exit 1; fi
	docker-compose -f docker/docker-compose.yml build hacker_cookbook
	@docker-compose -f docker/docker-compose.yml run hacker_cookbook /bin/bash

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

python: ## setup python stuff
	if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make python inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Set up the Python environment"
	if [ -f '$(REQS)' ]; then python -m pip install -r$(REQS); fi
