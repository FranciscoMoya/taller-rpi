FIGDIR=img

RUBBER_WARN ?= refs
RUBBER=rubber -I ../common -m hyperref $(RUBBER_FLAGS) --warn $(RUBBER_WARN) --pdf

MAIN = main.tex
TARGET = $(MAIN:.tex=.pdf)

TEX_SOURCE ?= $(shell ../common/latex-parts.sh $(MAIN))

TEX_FIGURES = $(foreach file, $(TEX_SOURCE), \
                  $(shell ../common/latex-figures.sh $(file)))

GENERATED_FIGURES = $(shell hg st --unknown --no-status $(TEX_FIGURES))

MAINS = $(shell find -name main.tex)

all: $(TARGET)

$(TARGET): $(TEX_SOURCE) $(TEX_FIGURES)

%.pdf: %.tex
	$(RUBBER) $<
	-@ ! grep --color Reference $(<:.tex=.log)
	-@ ! grep --color Citation $(<:.tex=.log)
	-@ ! grep --color "multiply defined" $(<:.tex=.log)
	-@ ! grep "acronym Warning" $(<:.tex=.log) | sort | uniq | grep --color "acronym Warning"

clean::
	$(RUBBER) --clean $(MAIN)
	$(RM) $(MAINS:.tex=.idx)
	$(RM) *~

clean-generated: clean
	$(RM) $(GENERATED_FIGURES)

include ../common/figures.mk
