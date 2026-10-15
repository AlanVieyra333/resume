#-----------------------------------------------------------------------
# Resume Makefile
#
# Profiles (each produces one PDF per language: English and Spanish):
#   devops      Original DevOps Engineer CV         -> out/Resume_DevOps_AFRV_{EN,ES}.pdf
#   fullstack   Senior Full Stack Developer CV      -> out/Resume_FullStack_AFRV_{EN,ES}.pdf
#   lead        DevOps/SRE Engineer Lead CV         -> out/Resume_DevOpsLead_AFRV_{EN,ES}.pdf
#
# Common targets:
#   make                default: builds the devops profile, both languages
#   make all            builds every profile, every language
#   make devops         builds only the devops profile (both languages)
#   make fullstack      builds only the fullstack profile (both languages)
#   make lead           builds only the lead profile (both languages)
#   make fullstack-en   builds fullstack profile, English only
#   make fullstack-es   builds fullstack profile, Spanish only
#   make lead-en        builds lead profile, English only
#   make lead-es        builds lead profile, Spanish only
#   make devops-en      builds devops profile, English only
#   make devops-es      builds devops profile, Spanish only
#   make docker         builds every PDF inside the texlive Docker image
#   make check          verifies profile invariants (scripts/check-profiles.sh)
#   make clean          removes out/ and every build artefact
#
# Output layout: every per-target rule writes its PDF to $(OUTDIR) (default
# `out/`) via `latexmk -outdir`. Intermediate files produced by latexmk in the
# repo root -- named after `-jobname`, so `resume_<profile>_<lang>.{aux,log,
# out,fls,fdb_latexmk,synctex.gz}` -- are deleted by the recipe itself after a
# successful build, so `make all` leaves a pristine repo root plus `out/`.
# `make clean` wipes `out/` and any stray root-level artefacts left over from
# a previous layout.
#-----------------------------------------------------------------------

PROFILE ?= devops

# Every source a PDF depends on. Do NOT use a `**/*.tex` glob here: GNU Make
# expands `**` like a single `*`, so `**/*.tex` resolves only to lang/*.tex and
# silently misses lang/fullstack/*.tex and lang/lead/*.tex -- editing those
# files would then produce a stale PDF with no error.
TEXSOURCES := main.tex $(wildcard lang/*.tex lang/*/*.tex) style.cls profile.png

# Final PDFs land in this directory. `latexmk -outdir=$(OUTDIR)` writes the
# PDF directly here (and auto-creates the directory if missing); the recipe
# then deletes the LaTeX intermediates that latexmk left in the repo root.
OUTDIR := out

.PHONY: all devops devops-en devops-es fullstack fullstack-en fullstack-es \
        lead lead-en lead-es docker check clean

#-----------------------------------------------------------------------
# Default and aggregate targets
#-----------------------------------------------------------------------

all: fullstack lead devops

#-----------------------------------------------------------------------
# Per-profile compilation
#
# Each profile/language triple is generated from the same source tree by
# setting `\profile` and `\lang` for that single pdflatex run. The PROFILE_RULE
# template expands into the six PDF rules below; adding a seventh profile is
# one new `$(call PROFILE_RULE,...)` line.
#
# Args: (1) profile id (lowercase, used inside `\def\profile{...}` and in the
# latexmk jobname); (2) language id (lowercase, used inside `\def\lang{...}`
# and in the jobname); (3) human-readable profile label (PascalCase, used in
# the output filename); (4) language suffix (uppercase, used in the output
# filename).
#
# Two portability choices in the recipe body:
#   - The intermediates are deleted via an explicit per-extension list, not
#     `{aux,log,...}` brace expansion. `make docker` runs `/bin/sh` inside the
#     texlive image, which is dash and does NOT perform bash-style brace
#     expansion: `{aux,log}` would be passed to `rm` as a single literal glob
#     and silently match nothing.
#   - The PDF rename (`mv`) is kept because `-outdir` only sets the output
#     directory; the filename still comes from `-jobname`, so without `mv`
#     Make's target `out/Resume_*.pdf` would never be satisfied and the rule
#     would rebuild on every `make` invocation.
#-----------------------------------------------------------------------

define PROFILE_RULE
$(OUTDIR)/Resume_$(3)_AFRV_$(4).pdf: $(TEXSOURCES)
	latexmk -pdf -outdir=$(OUTDIR) -interaction=nonstopmode -halt-on-error \
		-jobname=resume_$(1)_$(2) \
		-pdflatex="pdflatex %O '\def\profile{$(1)}\def\lang{$(2)}\input{main.tex}'"
	mv $(OUTDIR)/resume_$(1)_$(2).pdf $$@
	rm -f $(OUTDIR)/resume_$(1)_$(2).aux \
	      $(OUTDIR)/resume_$(1)_$(2).log \
	      $(OUTDIR)/resume_$(1)_$(2).out \
	      $(OUTDIR)/resume_$(1)_$(2).fls \
	      $(OUTDIR)/resume_$(1)_$(2).fdb_latexmk \
	      $(OUTDIR)/resume_$(1)_$(2).synctex.gz
	@echo "Built $$@"
endef

$(eval $(call PROFILE_RULE,fullstack,en,FullStack,EN))
$(eval $(call PROFILE_RULE,fullstack,es,FullStack,ES))
$(eval $(call PROFILE_RULE,lead,en,DevOpsLead,EN))
$(eval $(call PROFILE_RULE,lead,es,DevOpsLead,ES))
$(eval $(call PROFILE_RULE,devops,en,DevOps,EN))
$(eval $(call PROFILE_RULE,devops,es,DevOps,ES))

#-----------------------------------------------------------------------
# Phony per-profile convenience targets
#-----------------------------------------------------------------------

fullstack: $(OUTDIR)/Resume_FullStack_AFRV_EN.pdf $(OUTDIR)/Resume_FullStack_AFRV_ES.pdf
lead:      $(OUTDIR)/Resume_DevOpsLead_AFRV_EN.pdf $(OUTDIR)/Resume_DevOpsLead_AFRV_ES.pdf
devops:    $(OUTDIR)/Resume_DevOps_AFRV_EN.pdf   $(OUTDIR)/Resume_DevOps_AFRV_ES.pdf

fullstack-en: $(OUTDIR)/Resume_FullStack_AFRV_EN.pdf
fullstack-es: $(OUTDIR)/Resume_FullStack_AFRV_ES.pdf
lead-en:      $(OUTDIR)/Resume_DevOpsLead_AFRV_EN.pdf
lead-es:      $(OUTDIR)/Resume_DevOpsLead_AFRV_ES.pdf
devops-en:    $(OUTDIR)/Resume_DevOps_AFRV_EN.pdf
devops-es:    $(OUTDIR)/Resume_DevOps_AFRV_ES.pdf

#-----------------------------------------------------------------------
# Build inside the texlive Docker image used by CI
#
# `make docker` runs the container as root by default, which would leave
# `out/` (and any other artefact written to the bound mount) owned by root
# on the host. `--user` matches the invoking user's UID:GID so a subsequent
# `make clean` on the host does not need sudo.
#-----------------------------------------------------------------------

docker: $(TEXSOURCES)
	docker run -i --rm --user $(shell id -u):$(shell id -g) \
		-v `pwd`:/app -w /app texlive/texlive:TL2025-historic make all

#-----------------------------------------------------------------------
# Invariant checks across every profile (see FACTS.md)
#-----------------------------------------------------------------------

check:
	@bash scripts/check-profiles.sh

#-----------------------------------------------------------------------
# Cleanup
#-----------------------------------------------------------------------

clean:
	rm -rf $(OUTDIR)
	rm -f *.log *.out *.aux *.synctex.gz *.fls *.fdb_latexmk
	rm -f Resume_*.pdf
