
#SUBDIRS ?= $(sort $(filter-out $(wildcard .*),\
#	$(foreach d, $(shell find . -maxdepth 1 -type d ), $(notdir $(d)))))

SUBDIR_MAXDEPTH ?= 2
SUBDIRS ?= $(sort $(dir $(shell find . -mindepth 2 -maxdepth $(SUBDIR_MAXDEPTH) -name Makefile)))

all:       RULE = all
install:   RULE = install
uninstall: RULE = uninstall
clean:     RULE = clean
vclean:    RULE = vclean
clean-generated:    RULE = clean-generated

all clean clean-generated vclean install uninstall:: log subdirs post

log:
	@clear
	@printf "\n  === Applying \"$(RULE)\" ===\n"
	@printf "  - %s\n" $(SUBDIRS)

post:
	@printf "\n  === ALL OK!! ===\n"

.PHONY: log post subdirs $(SUBDIRS)
subdirs: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(RULE)
