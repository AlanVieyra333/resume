PROJ = cv_afrv

all: $(PROJ)_en.pdf $(PROJ)_es.pdf

$(PROJ)_en.pdf: *.tex *.cls *.jpg
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-jobname=cv_en \
		-pdflatex="pdflatex %O '\def\lang{en}\input{main.tex}'"
	mv cv_en.pdf $(PROJ)_en.pdf
	@echo "\nDone!"

$(PROJ)_es.pdf: *.tex *.cls *.jpg
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-jobname=cv_es \
		-pdflatex="pdflatex %O '\def\lang{es}\input{main.tex}'"
	mv cv_es.pdf $(PROJ)_es.pdf
	@echo "\nDone!"

docker: *.tex *.cls *.jpg
	docker run -it -v `pwd`:/app -w /app texlive/texlive:latest make

clean:
	rm -rf *.log *.out *.aux *.synctex.gz *.fls *.fdb_latexmk *.pdf

.PHONY: all docker clean
