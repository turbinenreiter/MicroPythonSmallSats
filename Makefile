SOURCE_DOCS := $(wildcard *.md)

EXPORTED_DOCS = \
	$(SOURCE_DOCS:.md=.html) \
	$(SOURCE_DOCS:.md=.pdf) \
	$(SOURCE_DOCS:.md=.tex)

RM = /bin/rm

PANDOC = /usr/local/bin/pandoc

PANDOC_OPTIONS = --table-of-contents --number-sections --smart --standalone
PANDOC_OPTIONS += --listings
PANDOC_OPTIONS += --normalize --self-contained
PANDOC_OPTIONS += --filter pandoc-citeproc
#--highlight-style pygments

PANDOC_HTML_OPTIONS = --include-in-header=resources/html/thesis.css --template=resources/html/thesis.html --to html5
PANDOC_PDF_OPTIONS = --template=resources/tex/lrt.tex --to latex
PANDOC_TEX_OPTIONS = --template=resources/tex/lrt.tex --biblatex --to latex


# Pattern-matching Rules

%.html : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o build/$@ build/tempmd

%.pdf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o build/$@ build/tempmd

%.tex : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_TEX_OPTIONS) -o build/$@ build/tempmd
	cp build/thesis.tex thesis.tex
	latexmk -f -pdf
	latexmk -c
	rm thesis.bbl
	rm thesis.run.xml
	rm thesis.tex

# Targets and dependencies

.PHONY: all clean

all: pre $(EXPORTED_DOCS)

pre:
	mkdir -p build
	gpp -H $(SOURCE_DOCS) > build/tempmd

clean:
	- $(RM) -r build
	latexmk -c
	rm thesis.bbl
	rm thesis.run.xml
	rm thesis.tex

