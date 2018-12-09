.PHONY: book lint

book: 
	book/makebook.sh

dev-env: 

lint: 
	if [ ! command -v mdl ]; then \
	  echo "gem: --no-document" >> ~/.gemrc;\
	  sudo gem install mdl;\
	fi
	find . -name '*.md' | xargs /usr/local/bin/mdl

#find . -name '*.md' | xargs /var/lib/gems/2.3.0/gems/mdl-0.4.0/bin/mdl
