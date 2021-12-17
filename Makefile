PROJ = CV_AFRV.pdf
MAIN = cv

$(PROJ): *.tex *.cls *.png
	pdflatex $(MAIN).tex
	mv $(MAIN).pdf $(PROJ)

build-docker:
	docker run -it -v $(pwd):/app -w /app texlive/texlive:latest make

clean:
	rm -rf *.log *.out *.aux *.synctex.gz *.pdf

.PHONY: clean
