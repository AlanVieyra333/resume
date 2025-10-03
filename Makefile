PROJ = CV_AFRV.pdf
MAIN = cv

$(PROJ): *.tex *.cls *.jpg
	latexmk -pdf -interaction=nonstopmode -halt-on-error $(MAIN).tex
	mv $(MAIN).pdf $(PROJ)
	@echo "\nDone!"

docker: *.tex *.cls *.jpg
	docker run -it -v `pwd`:/app -w /app texlive/texlive:latest make

clean:
	rm -rf *.log *.out *.aux *.synctex.gz *.fls *.fdb_latexmk *.pdf

.PHONY: docker clean
