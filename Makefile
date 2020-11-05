PROJ = CV_AFRV.pdf
MAIN = cv.tex

$(PROJ): *.tex *.cls *.png
	pdflatex -pdf $(MAIN)
	mv *.pdf $(PROJ)
