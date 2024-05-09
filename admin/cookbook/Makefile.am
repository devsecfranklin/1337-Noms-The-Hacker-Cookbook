CLOCAL_AMFLAGS = -I config/m4 -I aclocal
ACLOCAL_AMFLAGS = -I config/m4 -I aclocal

clean:
	rm -rf _build *.egg-info
	@find . -name '*.pyc' | xargs rm -rf
	@find . -name '__pycache__' | xargs rm -rf
	@for trash in *.aux *.bbl *.blg *.lof *.log *.lot *.out *.pdf *.synctex.gz *.toc ; do \
		if [ -f "$$trash" ]; then rm -rf $$trash ; fi ; \
        done

paper:
	latexmk -pdf -file-line-error -interaction=nonstopmode -synctex=1 -shell-escape hacker_cookbook
	bibtex hacker_cookbook
	latexmk -pdf -file-line-error -interaction=nonstopmode -synctex=1 -shell-escape hacker_cookbook
