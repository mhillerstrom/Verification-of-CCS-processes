# wineconsole C:/VTEX/BIN/vtex3h.exe -q -\$p\(c=9 @latex
TEXC=wineconsole C:/VTeX/BIN/vtex3h.exe
CFLAGS=-\$$p\(c=9,w=8.5in,h=11in @latex
TOOLS=mksnipplets.sh splitlines.awk Makefile
PAPER=verificationofccs-processes
SOURCES=abstract.tex anewsystem.tex appendixa.tex appendixb.tex appendixc.tex appendixd.tex \
        basictheory.tex conclusion.tex cover.tex existing.tex extendedsystem.tex implementation.tex \
        introduction.tex preface.tex thesisbib.tex thesisformat.tex titlepage.tex \
        verificationofccs-processes.tex
CODEDIR=prolog
EXAMPLEDIR=prolog/examples

.SUFFIXES: .inp .pl

all: $(PAPER).pdf

snipplets: codesnipplets examples

examples:
	(cd $(EXAMPLEDIR); make snipplets)

codesnipplets:
	(cd $(CODEDIR); make snipplets)

$(PAPER).aux: $(PAPER).tex
	$(TEXC) -q $(CFLAGS) $(PAPER)

$(PAPER).pdf: snipplets $(PAPER).aux $(SOURCES)
	$(TEXC) -q $(CFLAGS) $(PAPER)
	$(TEXC) $(CFLAGS) $(PAPER)

clean:
	rm -f *.aux *.bak *.brf *.lof *.log *.out *.toc *~
#	rm -f *.bbl *.blg *.fls *.xml
#	rm -f *.fdb_latexmk
	(cd $(CODEDIR); make clean)
	(cd $(EXAMPLEDIR); make clean)

