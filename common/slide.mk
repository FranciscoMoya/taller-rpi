# requires: unovonv, pdfjam, pdftk

.INTERMEDIATE: *.first.pdf *.2x2.pdf

IGNORE~=

PDFNUP=pdfnup --paper a4paper --quiet

ODP?=$(filter-out $(IGNORE), $(wildcard *.odp))
SLIDES1=$(patsubst %.odp,%.pdf, $(ODP))
SLIDESM=$(patsubst %.odp,%.2x4.pdf, $(ODP))

SLIDES=$(SLIDES1) $(SLIDESM)

all:  $(SLIDES)

%.pdf: %.odp
	odt2pdf $<

%.1x3.pdf: %.pdf
	$(PDFNUP) --no-landscape --scale 0.9 --delta "0.8cm 0.8cm" --frame true --offset "-3cm 0" --nup 1x3 $< --outfile $@

%.first.pdf: %.pdf
	$(PDFNUP) --delta "0.8cm 0.8cm" --frame true --nup 1x1 $< 1 --outfile $@

%.2x2.pdf: %.pdf
	$(PDFNUP) --delta "0.8cm 0.8cm" --frame true --nup 2x2 $< 2- --outfile $@

%.2x4.pdf: %.first.pdf %.2x2.pdf
	pdftk $^ cat output /tmp/aux-$(notdir $@)
	$(PDFNUP) --no-landscape --nup 1x2 --scale 0.9 --delta "0.45cm 0.45cm" /tmp/aux-$(notdir $@) --outfile $@
	$(RM) /tmp/aux-$(notdir $@)

clean::
	$(RM) *~ $(SLIDES)

vclean:: clean
