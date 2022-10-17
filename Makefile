# wineconsole C:/VTEX/BIN/vtex3h.exe -q -\$p\(c=9 @latex
# TEXC=wineconsole C:/VTeX/BIN/vtex3h.exe
# CFLAGS=-\$$p\(c=9,w=8.5in,h=11in @latex
IMAGE=mhillerstrom/thesis
DPREF=/workspace
OUTDIR=out
CODEDIR=prolog
EXAMPLEDIR=prolog/examples

TEXFLAGS=-output-directory=$(DPREF)/$(OUTDIR) -interaction=scrollmode -pdf
TEXC=docker run -v `pwd`:$(DPREF) --rm -t --entrypoint=latex $(IMAGE) $(TEXFLAGS)
PDFC=docker run -v `pwd`:$(DPREF) --rm -t --entrypoint=latexmk $(IMAGE) $(TEXFLAGS)
CFLAGS=

PROLOG=docker run -v `pwd`:$(DPREF) --rm -t -a stdout --entrypoint=swipl swipl --traditional -s
TOOLS=mksnipplets.sh splitlines.awk Makefile

PAPER=verificationofccs-processes
SOURCES=abstract.tex anewsystem.tex appendixa.tex appendixb.tex appendixc.tex appendixd.tex \
        basictheory.tex conclusion.tex cover.tex existing.tex extendedsystem.tex implementation.tex \
        introduction.tex preface.tex thesisbib.tex thesisformat.tex titlepage.tex \
        verificationofccs-processes.tex

.SUFFIXES: .inp .pl

all: docker $(PAPER).pdf ## Make the thesis PDF

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

docker: ## Make sure the necessary Doocker images/containers are available
	$(if $(strip $(shell docker images -q ${IMAGE} 2> /dev/null)),,docker build -t $(IMAGE) .)

snipplets: codesnipplets examples ## Make the code sniplets and the examples

examples: ## Make the examples
	(cd $(EXAMPLEDIR); make snipplets)

codesnipplets: ## Make the code sniplets
	(cd $(CODEDIR); make snipplets)

$(PAPER).aux: $(PAPER).tex ## Compile the TeX document
	$(PDFC) $(CFLAGS) $(DPREF)/$(PAPER)
	mv $(OUTDIR)/$(PAPER).pdf thesis.pdf

$(PAPER).pdf: snipplets $(PAPER).aux $(SOURCES) ## Make the thesis PDF
	#$(TEXC) $(CFLAGS) $(DPREF)/$(PAPER)
	#$(TEXC) $(CFLAGS) $(DPREF)/$(PAPER)
	$(PDFC) $(CFLAGS) $(DPREF)/$(PAPER)

clean: ## Remove all auxilliary files
	(cd $(OUTDIR); rm -f *.aux *.bak *.brf *.lof *.log *.out *.toc *~ *.fls *.dvi *.fdb_latexmk)
	(cd $(CODEDIR); make clean)
	(cd $(EXAMPLEDIR); make clean)
