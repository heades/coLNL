PDFLATEX = pdflatex
BIBTEX = bibtex
OTT = ott
OTT_FLAGS := -tex_wrap false -tex_show_meta true -picky_multiple_parses false
SKIM := skim_revert.sh
SKIMRevinPath := $(shell command -v $(SKIM) 2> /dev/null)

all: pdf
  # This is for my private machine.  It forces my PDF reader to reload.
  # It should not run unless "skim_revert.sh" is in your PATH.
  ifdef SKIMRevinPath
	$(SKIM) $(CURDIR)/main.pdf
	$(SKIM) $(CURDIR)/main.pdf
	$(SKIM) $(CURDIR)/main.pdf
  endif

pdf : main.pdf

quick : main-output.tex ref.bib Makefile
	$(PDFLATEX) -jobname=main main-output.tex
        # This is for my private machine.  It forces my PDF reader to reload.
        # It should not run unless "skim_revert.sh" is in your PATH.
ifdef SKIMRevinPath
	$(SKIM) $(CURDIR)/main.pdf
	$(SKIM) $(CURDIR)/main.pdf
	$(SKIM) $(CURDIR)/main.pdf
endif

ott: main-output.tex

DLNL-proofs-output.tex : coLNL-logic/coLNL-logic.ott DLNL-proofs.tex
	@echo "\n\n***OTT: Preprocessing coLNL-logic/coLNL-logic.ott in DLNL-proofs.tex.***"
	@$(OTT) $(OTT_FLAGS) -i coLNL-logic/coLNL-logic.ott  -o DualLNLLogic-inc.tex -tex_name_prefix DualLNLLogic \
		-tex_filter DLNL-proofs.tex DLNL-proofs-output.tex

dualLNL-logic-output.tex : coLNL-logic/coLNL-logic.ott dualLNL-logic.tex
	@echo "\n\n***OTT: Preprocessing coLNL-logic/coLNL-logic.ott in dualLNL-logic.tex.***"
	@$(OTT) $(OTT_FLAGS) -i coLNL-logic/coLNL-logic.ott  -o DualLNLLogic-inc.tex -tex_name_prefix DualLNLLogic \
		-tex_filter dualLNL-logic.tex dualLNL-logic-output.tex

main-output.tex : main.tex coLNL-logic/coLNL-logic.ott dualLNL-logic-output.tex DLNL-proofs-output.tex
	@echo "\n\n***OTT: Preprocessing dtt.ott in main.tex.***"
	@$(OTT) $(OTT_FLAGS) -i coLNL-logic/coLNL-logic.ott  -o DualLNLLogic-inc.tex -tex_name_prefix DualLNLLogic \
		-tex_filter main.tex main-output.tex

# Now this takes the full LaTex translation and compiles it using
# pdflatex.
main.pdf : main-output.tex ref.bib Makefile dualLNL-logic-output.tex introduction.tex DLNL-proofs-output.tex
	$(PDFLATEX) -jobname=main main-output.tex
	$(BIBTEX) main
	$(PDFLATEX) -jobname=main main-output.tex
	$(PDFLATEX) -jobname=main main-output.tex

clean :
	rm -f *.aux *.dvi *.ps *.log *-ott.tex *-output.tex *.bbl *.blg *.rel *.pdf *~ *.vtc *.out *.spl *-inc.tex
