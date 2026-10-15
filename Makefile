#-----------------------------------------------------------------------
# Resume Makefile
#
# Profiles (each produces one PDF per language: English and Spanish):
#   devops      Original DevOps Engineer CV         -> Resume_DevOps_AFRV_{EN,ES}.pdf
#   fullstack   Senior Full Stack Developer CV      -> Resume_FullStack_AFRV_{EN,ES}.pdf
#   lead        DevOps/SRE Engineer Lead CV         -> Resume_DevOpsLead_AFRV_{EN,ES}.pdf
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
#   make clean          removes build artefacts
#-----------------------------------------------------------------------

PROFILE ?= devops

# Every source a PDF depends on. Do NOT use a `**/*.tex` glob here: GNU Make
# expands `**` like a single `*`, so `**/*.tex` resolves only to lang/*.tex and
# silently misses lang/fullstack/*.tex and lang/lead/*.tex -- editing those
# files would then produce a stale PDF with no error.
TEXSOURCES := main.tex $(wildcard lang/*.tex lang/*/*.tex) style.cls profile.png

.PHONY: all devops devops-en devops-es fullstack fullstack-en fullstack-es \
        lead lead-en lead-es docker check clean

#-----------------------------------------------------------------------
# Default and aggregate targets
#-----------------------------------------------------------------------

all: fullstack lead devops

#-----------------------------------------------------------------------
# Senior Full Stack Developer profile
#   lang/fullstack/en.tex and lang/fullstack/es.tex
#-----------------------------------------------------------------------

fullstack: fullstack-en fullstack-es

fullstack-en: Resume_FullStack_AFRV_EN.pdf
fullstack-es: Resume_FullStack_AFRV_ES.pdf

Resume_FullStack_AFRV_EN.pdf: $(TEXSOURCES)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-jobname=resume_fullstack_en \
		-pdflatex="pdflatex %O '\def\profile{fullstack}\def\lang{en}\input{main.tex}'"
	mv resume_fullstack_en.pdf $@
	@echo "Built $@"

Resume_FullStack_AFRV_ES.pdf: $(TEXSOURCES)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-jobname=resume_fullstack_es \
		-pdflatex="pdflatex %O '\def\profile{fullstack}\def\lang{es}\input{main.tex}'"
	mv resume_fullstack_es.pdf $@
	@echo "Built $@"

#-----------------------------------------------------------------------
# DevOps/SRE Engineer Lead profile
#   lang/lead/en.tex and lang/lead/es.tex
#-----------------------------------------------------------------------

lead: lead-en lead-es

lead-en: Resume_DevOpsLead_AFRV_EN.pdf
lead-es: Resume_DevOpsLead_AFRV_ES.pdf

Resume_DevOpsLead_AFRV_EN.pdf: $(TEXSOURCES)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-jobname=resume_lead_en \
		-pdflatex="pdflatex %O '\def\profile{lead}\def\lang{en}\input{main.tex}'"
	mv resume_lead_en.pdf $@
	@echo "Built $@"

Resume_DevOpsLead_AFRV_ES.pdf: $(TEXSOURCES)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-jobname=resume_lead_es \
		-pdflatex="pdflatex %O '\def\profile{lead}\def\lang{es}\input{main.tex}'"
	mv resume_lead_es.pdf $@
	@echo "Built $@"

#-----------------------------------------------------------------------
# DevOps Engineer profile (existing behaviour)
#   lang/en.tex and lang/es.tex
#-----------------------------------------------------------------------

devops: devops-en devops-es

devops-en: Resume_DevOps_AFRV_EN.pdf
devops-es: Resume_DevOps_AFRV_ES.pdf

Resume_DevOps_AFRV_EN.pdf: $(TEXSOURCES)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-jobname=resume_devops_en \
		-pdflatex="pdflatex %O '\def\lang{en}\input{main.tex}'"
	mv resume_devops_en.pdf $@
	@echo "Built $@"

Resume_DevOps_AFRV_ES.pdf: $(TEXSOURCES)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-jobname=resume_devops_es \
		-pdflatex="pdflatex %O '\def\lang{es}\input{main.tex}'"
	mv resume_devops_es.pdf $@
	@echo "Built $@"

#-----------------------------------------------------------------------
# Build inside the texlive Docker image used by CI
#-----------------------------------------------------------------------

docker: $(TEXSOURCES)
	docker run -i --rm -v `pwd`:/app -w /app texlive/texlive:TL2025-historic make all

#-----------------------------------------------------------------------
# Invariant checks across every profile (see FACTS.md)
#-----------------------------------------------------------------------

check:
	@bash scripts/check-profiles.sh

#-----------------------------------------------------------------------
# Cleanup
#-----------------------------------------------------------------------

clean:
	rm -rf *.log *.out *.aux *.synctex.gz *.fls *.fdb_latexmk *.pdf
