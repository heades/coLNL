PDFLATEX = pdflatex
BIBTEX = bibtex
OTT = ott
OTT_FLAGS := -tex_show_meta false -tex_wrap false
SKIM := skim_revert.sh
SKIMRevinPath := $(shell command -v $(SKIM) 2> /dev/null)

all: pdf
  # This is for my private machine.  It forces my PDF reader to reload.
  # It should not run unless "skim_revert.sh" is in your PATH.
  ifdef SKIMRevinPath	
	@$(SKIM) coint.pdf &>/dev/null
	@$(SKIM) coint.pdf &>/dev/null
	@$(SKIM) coint.pdf &>/dev/null
  endif

pdf : coint.pdf

coint-ott.tex : coint.ott
	$(OTT) $(OTT_FLAGS) -i coint.ott -o coint-ott.tex

coint.pdf : coint.tex Makefile coint-ott.tex
	$(PDFLATEX) coint.tex

clean :
	rm -f *.aux *.dvi *.ps *.log *-ott.tex *-output.tex *.bbl *.blg *.rel *.pdf *~ *.vtc *.out *.spl *-inc.tex
