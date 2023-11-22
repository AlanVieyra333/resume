PROJ = CV_AFRV.pdf
MAIN = cv

$(PROJ): *.tex *.cls *.png
	pdflatex $(MAIN).tex
	mv $(MAIN).pdf $(PROJ)
	@echo "\nDone!"

docker: *.tex *.cls *.png
	docker run -it -v `pwd`:/app -w /app texlive/texlive:latest make

clean:
	rm -rf *.log *.out *.aux *.synctex.gz *.pdf

.PHONY: docker clean
