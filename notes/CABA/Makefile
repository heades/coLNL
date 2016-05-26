PDFLATEX=pdflatex
SKIM = skim_revert.sh

all : pdf

pdf : note.pdf
	$(SKIM) $(CURDIR)/note.pdf

note.pdf : note.tex
	$(PDFLATEX) note.tex
# bibtex note
# $(PDFLATEX) note.tex
# $(PDFLATEX) note.tex
# $(PDFLATEX) note.tex

clean : 
	rm -f *.aux *.dvi *.ps *.log *.pdf *~ *.out
