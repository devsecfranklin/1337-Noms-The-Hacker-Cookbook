CLOCAL_AMFLAGS = -I config/m4 -I aclocal
ACLOCAL_AMFLAGS = -I config/m4 -I aclocal

.PHONY: clean docker python

clean:
	rm -rf _build *.egg-info
	@find . -name '*.pyc' | xargs rm -rf
	@find . -name '__pycache__' | xargs rm -rf
	@for trash in aclocal.m4 autom4te.cache config config.log config.status configure configure~ libtool Makefile Makefile.in docker/cloudbot/Makefile docker/cloudbot/Makefile.in; do \
	if [ -f $$trash ] || [ -d $$trash ]; then \
		echo "Removing $$trash" ;\
		rm -rf $$trash ;\
	fi ; \
	done

docker:
	@if [ -f /.dockerenv ]; then echo "Don't run make docker inside docker container" && exit 1; fi
	docker-compose -f docker/docker-compose.yml build hacker_cookbook
	@docker-compose -f docker/docker-compose.yml run hacker_cookbook /bin/bash

python: 
	python3 -m venv _build
	( \
		source _build/bin/activate; \
		_build/bin/python -m pip install --upgrade pip; \
		_build/bin/python -m pip install -rsrc/requirements.txt; \
	)
