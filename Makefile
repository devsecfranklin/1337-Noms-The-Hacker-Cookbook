.PHONY: book lint

book: ## Generate a PDF copy of the Hacker Cookbook
	book/makebook.sh

dev-env: 

lint: ## check the Markdown files for issues
	if [ ! command -v mdl ]; then \
	  echo "gem: --no-document" >> ~/.gemrc;\
	  sudo gem install mdl;\
	fi
	find . -name '*.md' | xargs /usr/local/bin/mdl

#find . -name '*.md' | xargs /var/lib/gems/2.3.0/gems/mdl-0.4.0/bin/mdl
