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
	@$(SKIM) coLNL-logic.pdf &>/dev/null
	@$(SKIM) coLNL-logic.pdf &>/dev/null
	@$(SKIM) coLNL-logic.pdf &>/dev/null
  endif

pdf : coLNL-logic.pdf

coLNL-logic-ott.tex : coLNL-logic.ott
	$(OTT) $(OTT_FLAGS) -i coLNL-logic.ott -o coLNL-logic-ott.tex

coLNL-logic.pdf : coLNL-logic.tex Makefile coLNL-logic-ott.tex
	$(PDFLATEX) coLNL-logic.tex

clean :
	rm -f *.aux *.dvi *.ps *.log *-ott.tex *-output.tex *.bbl *.blg *.rel *.pdf *~ *.vtc *.out *.spl *-inc.tex
