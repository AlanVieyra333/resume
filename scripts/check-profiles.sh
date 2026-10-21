#!/usr/bin/env bash
#
# check-profiles.sh -- invariant checks across every resume profile.
#
# The repo compiles the same career facts into eight content files (4 profiles x
# EN/ES) that must never contradict each other. This script verifies the
# mechanical invariants so drift is caught by `make check` instead of by a
# recruiter. See FACTS.md for the source of truth behind every rule here.
#
# Exit 0 = all green, exit 1 = at least one failure.

set -uo pipefail
cd "$(dirname "$0")/.."

FAIL=0
pass() { printf '  \033[32mok\033[0m   %s\n' "$1"; }
fail() { printf '  \033[31mFAIL\033[0m %s\n' "$1"; FAIL=1; }

EN_FILES="lang/en.tex lang/fullstack/en.tex lang/lead/en.tex lang/ai/en.tex"
ES_FILES="lang/es.tex lang/fullstack/es.tex lang/lead/es.tex lang/ai/es.tex"
ALL_FILES="$EN_FILES $ES_FILES"
# Copy-paste blocks that get published verbatim -- same claim rules apply.
PUBLISHED="linkedin/perfil.md"

# Profile pairs: EN and ES must agree on employers, dates and metrics.
PAIRS="lang/en.tex:lang/es.tex
lang/fullstack/en.tex:lang/fullstack/es.tex
lang/lead/en.tex:lang/lead/es.tex
lang/ai/en.tex:lang/ai/es.tex"

# For .md, scan only the fenced ```text blocks (the copy-paste content).
# Editorial prose outside them discusses the rules; it is not a claim.
# The mobile markers are kept in the stream even though they live outside the
# fences: they are what scopes the runbook check, and they must not reach the
# copy the user pastes into LinkedIn.
published_body() {
    if [ "${1##*.}" = "md" ]; then
        awk '
            /^```text$/ {f=1; next}
            /^```$/     {f=0; next}
            f {print; next}
            /<!-- mobile-(begin|end) -->/ {print}
        ' "$1"
    else
        cat "$1"
    fi
}

echo "== Profile files exist =="
for f in $ALL_FILES; do
    [ -f "$f" ] && pass "$f" || fail "$f missing"
done

echo
echo "== Forbidden employer name =="
# Citibanamex -> Banamex was a deliberate rename. The old name must be gone.
# Scope: the eight content files only. FACTS.md documents this rename on purpose.
if grep -n "Citibanamex" $ALL_FILES $PUBLISHED 2>/dev/null | grep -v "el nombre correcto"; then
    fail "Citibanamex still present in CV content -- the correct name is Banamex"
else
    pass "no Citibanamex in any profile"
fi

echo
echo "== Internal identifiers are generalised, never published =="
# Names of the client's own boards, wikis and tagging conventions say nothing to
# a recruiter and read as copied internal text. FACTS.md section 4c records the
# real names and the public wording each one maps to.
INTERNAL="Tortugas Furiosas|Cambios de Ambiente|Versiones de imágenes base|Versiones de imagenes base"
internal_fail=0
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -oE "$INTERNAL" | sort -u | tr '\n' ' ')
    if [ -n "$hits" ]; then
        fail "$f publishes internal identifiers: $hits"
        internal_fail=1
    fi
done
# The public wording must still be there, or the bullet lost its substance.
for f in $ALL_FILES; do
    if ! published_body "$f" | grep -qiE "dashboards and boards|dashboards y boards"; then
        fail "$f lost the generalised Azure DevOps coordination wording"
        internal_fail=1
    fi
done
[ "$internal_fail" -eq 0 ] && pass "no board/wiki/tag names published; coordination described generically"

echo
echo "== Unconfirmed claims must not appear =="
# Each of these was explicitly NOT confirmed by Alan. See FACTS.md section 4.
# Pattern is case-insensitive and matches word-ish boundaries where practical.
#
# "runbook" is NOT in this list: the runbook ban came from the employment
# history, where no runbook was ever confirmed. The freelance mobile
# engagement DOES ship 12 runbooks as part of its delivery contract, so
# runbooks are checked separately, against the employment history only.
FORBIDDEN="error budget|post-?mortem|root cause analysis|postmortem|\bSLIs?\b|error budgets"
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -oiE "$FORBIDDEN" | sort -u | tr '\n' ' ')
    [ -n "$hits" ] && fail "$f contains unconfirmed terms: $hits"
done
pass "no SLO/SLI, error budget or postmortem claims"

echo
echo "== No profile may imply machine learning =="
# The AI work is applied/agentic: skills that route a natural-language request
# to a deterministic script. There is no model training, no RAG, no vector store,
# no MLOps and no LLM API in the career facts (FACTS.md section 4), so no
# profile and no published block may hint at one.
FORBIDDEN_ML="fine-?tun|\bRAG\b|embeddings?|vector (database|store)|MLOps|model training|machine learning|deep learning|foundation model|modelo de lenguaje|modelo fundacional|entrenamiento de modelos|entren[oó] un modelo|aprendizaje autom[aá]tico|redes neuronales|API de LLM|APIs de LLM|semantic search|b[uú]squeda sem[aá]ntica"
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    if [ "${f##*.}" = "md" ]; then
        hits=$(published_body "$f" | grep -oiE "$FORBIDDEN_ML" | sort -u | tr '\n' ' ')
    else
        # LaTeX comments are source documentation, not published text: the AI
        # profile's header comment names the excluded terms ON PURPOSE, to
        # document the boundary for whoever edits it next. The ban applies to
        # what the reader actually sees.
        hits=$(sed -e 's/^[[:space:]]*%.*$//' "$f" | grep -oiE "$FORBIDDEN_ML" | sort -u | tr '\n' ' ')
    fi
    [ -n "$hits" ] && fail "$f implies ML work that does not exist: $hits"
done
pass "no model training, RAG, embeddings, MLOps or LLM API claims"

# The freelance mobile sub-entry is stripped out before the runbook check: the
# runbook claim is legitimate THERE and nowhere else. The sub-entry is
# delimited by explicit markers, because it now shares a section with the
# compliance platform -- a heading can no longer scope it.
strip_mobile_section() {
    case "${1##*.}" in
        # The .md branch reads STDIN, because what has to be scanned there is
        # the published stream (the ```text blocks), not the whole file.
        md) awk '/<!-- mobile-begin -->/{m=1;next} /<!-- mobile-end -->/{m=0;next} !m{print}' ;;
        # The .tex branch reads the FILE. It used to read stdin as well, which
        # meant it scanned nothing at all (stdin was at EOF) and hung whenever
        # stdin stayed open.
        *)  awk '/^% mobile-begin/{m=1;next} /^% mobile-end/{m=0;next} !m{print}' "$1" ;;
    esac
}
runbook_fail=0
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    if [ "${f##*.}" = "md" ]; then
        hits=$(published_body "$f" | strip_mobile_section "$f" | grep -oiE "\brunbooks?\b" | sort -u | tr '\n' ' ')
    else
        hits=$(strip_mobile_section "$f" | grep -oiE "\brunbooks?\b" | sort -u | tr '\n' ' ')
    fi
    if [ -n "$hits" ]; then
        fail "$f claims runbooks outside the mobile delivery contract: $hits"
        runbook_fail=1
    fi
done
[ "$runbook_fail" -eq 0 ] && pass "runbooks are only claimed in the mobile delivery contract"

echo
echo "== Hexagonal architecture is framed as REVIEWED, never implemented =="
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    if published_body "$f" | grep -qiE "implement(e|ed|ó|ando|ado) (la |the )?(arquitectura )?hexagonal|hexagonal architecture implementation"; then
        fail "$f claims to have IMPLEMENTED the hexagonal architecture (he reviewed it)"
    fi
done
# Where hexagonal is mentioned at all, a review verb must be present nearby.
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    if published_body "$f" | grep -qi "hexagonal"; then
        if ! published_body "$f" | grep -qiE "revis(e|é|ó|ando|ado|iewed)|review"; then
            fail "$f mentions hexagonal without a review verb"
        fi
    fi
done
pass "hexagonal is only ever claimed as reviewed"

echo
echo "== Employer names identical across profiles =="
for e in "Veradat Smart Network" "IDS Comercial" "GLOBAL HITSS" "Everis" "Grupo de la Parra"; do
    for f in $ALL_FILES; do
        grep -q "$e" "$f" || fail "$f does not name employer '$e'"
    done
done
pass "every profile names the same employers"

echo
echo "== Date ranges consistent within each EN/ES pair =="
check_pair() {
    en="$1"; es="$2"
    # Normalise the Spanish month abbreviations onto the English ones.
    norm_es() {
        sed -e 's/Ene /Jan /g' -e 's/Ago /Aug /g' -e 's/Dic /Dec /g' \
            -e 's/Actualidad/Present/g' -e 's/jul /Jul /g' -e 's/sep /Sep /g' \
            -e 's/dic /Dec /g' -e 's/ago /Aug /g'
    }
    en_dates=$(grep -oE '[A-Z][a-z]{2} [0-9]{4} -- [A-Z][a-z]{2}? ?[0-9]{0,4}|Actualidad|[A-Z][a-z]{2} [0-9]{4} -- [A-Z][a-z]{2} [0-9]{4}' "$en" | sort -u)
    es_dates=$(norm_es < "$es" | grep -oE '[A-Z][a-z]{2} [0-9]{4} -- [A-Z][a-z]{2} ?[0-9]{0,4}|Present|[A-Z][a-z]{2} [0-9]{4} -- [A-Z][a-z]{2} [0-9]{4}' | sort -u)
    if [ "$en_dates" != "$es_dates" ]; then
        fail "date mismatch between $(basename "$en") and $(basename "$es")"
        printf '       EN: %s\n' "$(echo "$en_dates" | tr '\n' ' ')"
        printf '       ES: %s\n' "$(echo "$es_dates" | tr '\n' ' ')"
    fi
}
echo "$PAIRS" | while IFS=: read -r en es; do check_pair "$en" "$es"; done
pass "date ranges agree between EN and ES siblings"

echo
echo "== Key metrics present with the same value in every profile =="
# value -> regex matching both the English and the Spanish rendering.
check_metric() {
    label="$1"; en_re="$2"; es_re="$3"
    for f in $EN_FILES; do
        grep -qiE "$en_re" "$f" || fail "$f is missing metric: $label"
    done
    for f in $ES_FILES; do
        grep -qiE "$es_re" "$f" || fail "$f is missing metric: $label"
    done
}
check_metric "70 microservices"            "70 microservices"        "70 microservicios"
check_metric "20 CI/CD pipelines"          "20 Azure DevOps CI/CD"   "20 pipelines de CI/CD"
# Shell scripting automation is split by employer: 20 processes at Veradat and
# 10 at IDS Comercial, 30 in total. Each profile carries both figures.
check_metric "20 shell-scripted processes (Veradat)" "20 infrastructure processes with shell scripting" "20 procesos de infraestructura con shell scripting"
check_metric "10 shell-scripted processes (IDS)"    "10 infrastructure processes with shell scripting" "10 procesos de infraestructura con shell scripting"
check_metric "6h -> 1h deployment"         "6 hours to 1 hour"        "6 horas a 1 hora"
check_metric "9 QA clusters"               "9 in QA on Kubernetes"    "9 en QA sobre Kubernetes"
# The pre-production estate was consolidated to 21 clusters (9 QA, 4 DEV,
# 4 INTGR, 4 Certificación) in the 2026-10 pass. The full breakdown now
# lives in the Veradat bullet of every profile, so the summary wording
# "21 de preproducción" is no longer needed as an alternative.
check_metric "21 pre-production clusters"  "21 pre-production clusters" "21 clústeres de preproducción"
check_metric "60 -> 30 min detection"      "60 to 30 minutes"         "60 a 30 minutos"
check_metric "2h -> 20 min provisioning"   "2 hours to 20 minutes"    "2 horas a 20 minutos"
check_metric "~1,000 transactions/day"     "1(,|\\{,\\})000 transactions" "1(,|\\{,\\})000 transacciones"
check_metric "5,000 employees"             "5(,|\\{,\\})000 employees" "5(,|\\{,\\})000 empleados"
check_metric "1-day ServiceNow SLA"        "1-day (ServiceNow )?SLA"   "SLA de 1 día"
pass "core metrics consistent across all eight profiles"

echo
echo "== Independent projects: one section, two sub-entries, mobile dated 2023-2026 =="
# The freelance mobile work and the compliance platform are both independent
# projects, so they share ONE section per profile with two sub-entries -- never
# one section per project, and never by project name. The sub-entries are
# delimited by explicit markers, which is also what scopes the runbook check.
MOBILE_TITLE_EN="Mobile App Development (React Native)"
MOBILE_TITLE_ES="Desarrollo de Aplicaciones Móviles (React Native)"
COMPLIANCE_TITLE_EN="Subcontracting Law Compliance Management System"
COMPLIANCE_TITLE_ES="Sistema de Gestión de Cumplimiento de la Ley de Subcontratación"
for f in $EN_FILES; do
    n=$(grep -cE "^.section.*Independent Projects" "$f")
    [ "$n" = "1" ] || fail "$f has $n independent-projects sections -- expected exactly one"
    grep -qF "$MOBILE_TITLE_EN" "$f" || fail "$f has no mobile sub-entry"
    grep -qF "$COMPLIANCE_TITLE_EN" "$f" || fail "$f has no compliance sub-entry"
    grep -q "React Native" "$f" || fail "$f does not mention React Native"
    grep -q "Expo" "$f" || fail "$f does not mention Expo"
    grep -qF "2023 -- 2026" "$f" || fail "$f does not date the mobile sub-entry as 2023 -- 2026"
    grep -q "^% mobile-begin" "$f" || fail "$f is missing the % mobile-begin marker"
    grep -q "^% mobile-end" "$f" || fail "$f is missing the % mobile-end marker"
done
for f in $ES_FILES; do
    n=$(grep -cE "^.section.*Proyectos Destacados e Independientes" "$f")
    [ "$n" = "1" ] || fail "$f has $n independent-projects sections -- expected exactly one"
    grep -qF "$MOBILE_TITLE_ES" "$f" || fail "$f has no mobile sub-entry"
    grep -qF "$COMPLIANCE_TITLE_ES" "$f" || fail "$f has no compliance sub-entry"
    grep -q "React Native" "$f" || fail "$f does not mention React Native"
    grep -q "Expo" "$f" || fail "$f does not mention Expo"
    grep -qF "2023 -- 2026" "$f" || fail "$f does not date the mobile sub-entry as 2023 -- 2026"
    grep -q "^% mobile-begin" "$f" || fail "$f is missing the % mobile-begin marker"
    grep -q "^% mobile-end" "$f" || fail "$f is missing the % mobile-end marker"
done
# The old, month-level dating of the mobile work is gone for good.
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -oE "Aug 2026 -- Present|Ago 2026 -- Actualidad" | sort -u | tr '\n' ' ')
    [ -n "$hits" ] && fail "$f still dates the mobile work with months: $hits"
done
# The section must not name the individual projects.
MOBILE_NAMES="findafriend|find a friend|mi-prension|random.?binary"
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -oiE "$MOBILE_NAMES" | sort -u | tr '\n' ' ')
    [ -n "$hits" ] && fail "$f names individual mobile projects: $hits"
done
pass "one independent-projects section per profile, two sub-entries, React Native + Expo, 2023-2026, no project names"

echo
echo "== Mobile section does not overclaim =="
# The apps are not published in any store, have no users and earn no revenue.
# See FACTS.md section 3 for what the mobile engagement may and may not say.
MOBILE_OVERCLAIM="App Store|Play Store|Google Play|tienda de apps|descargas|downloads|usuarios activos|active users|monetiz|revenue|live payments|pagos activos"
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -oiE "$MOBILE_OVERCLAIM" | sort -u | tr '\n' ' ')
    [ -n "$hits" ] && fail "$f overclaims on the mobile work: $hits"
done
pass "no store publication, user-count or revenue claims"

echo
echo "== ISO 27001 role is controls, not audit or certification =="
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -iE "ISO.{0,40}(auditor|certif)|(auditor|certif).{0,40}ISO")
    [ -n "$hits" ] && fail "$f ties ISO 27001 to audit/certification -- his role was implementing controls"
done
pass "no audit/certification claim attached to ISO 27001"

echo
echo "== AI profile: the Claude Code plugin is published with its real numbers =="
# The plugin is the whole point of the AI profile, and its figures come from
# the suite itself: 4 skills, 35 Python scripts, about 3,200 lines of SKILL.md.
AI_FILES="lang/ai/en.tex lang/ai/es.tex"
for f in $AI_FILES; do
    grep -qF "Claude Code" "$f" || fail "$f does not mention Claude Code"
    grep -qF "SKILL.md" "$f" || fail "$f does not document the skills"
    grep -qE "4 skills" "$f" || fail "$f does not state the number of skills"
    grep -qE "35 scripts" "$f" || fail "$f does not state the number of scripts"
done
# The number of capabilities is NOT published: the generated index says 17 and
# the frontmatter says 18, so no single figure is verifiable (FACTS.md 3).
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -oiE "\b[0-9]+ (capacit|capabilit)" | sort -u | tr '\n' ' ')
    [ -n "$hits" ] && fail "$f publishes a capability count -- there is no single verifiable figure: $hits"
done
pass "AI profile publishes the plugin with its real numbers and no capability count"

echo
echo "== Agentic development stack: only inside the mobile delivery =="
# Superpowers, Matt Pocock Skills, Ponytail, Karpathy Guidelines and Codebase
# Memory MCP are third-party tools Alan USES in his own delivery work. They
# are NOT what he builds at Veradat: there he builds custom skills of his own
# for the organization's DevOps tasks (FACTS.md section 3). The stack therefore
# lives inside the mobile sub-entry and nowhere else -- the check is strict,
# because mixing the two is exactly the confusion this rule exists to prevent.
AGENTIC_TOOLS="Superpowers|Matt Pocock|Ponytail|Karpathy|Codebase Memory MCP"

# The stream that is scanned: the published copy of the .md (its ```text
# blocks only) or the whole .tex file with its comments stripped. The mobile
# markers are rewritten first, because in the .tex files they ARE comments and
# would be stripped with the rest.
ag_stream() {
    case "${1##*.}" in
        md) published_body "$1" \
             | sed -e 's/<!-- mobile-begin -->/@@MOB_BEGIN@@/' \
                   -e 's/<!-- mobile-end -->/@@MOB_END@@/' ;;
        *)  sed -e 's/^% mobile-begin$/@@MOB_BEGIN@@/' \
                -e 's/^% mobile-end$/@@MOB_END@@/' \
                -e 's/^[[:space:]]*%.*$//' "$1" ;;
    esac
}
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    stream=$(ag_stream "$f")
    inside=$(printf '%s\n' "$stream" \
        | awk '/@@MOB_BEGIN@@/{m=1;next} /@@MOB_END@@/{m=0;next} m{print}' \
        | grep -oE "$AGENTIC_TOOLS" | sort -u | wc -l | tr -d ' ')
    outside=$(printf '%s\n' "$stream" \
        | awk '/@@MOB_BEGIN@@/{m=1;next} /@@MOB_END@@/{m=0;next} !m{print}' \
        | grep -oE "$AGENTIC_TOOLS" | sort -u | wc -l | tr -d ' ')
    [ "$inside" = "5" ] || fail "$f names only $inside of the 5 agentic tools inside the mobile delivery"
    [ "$outside" = "0" ] || fail "$f names the agentic tools outside the mobile delivery"
done
pass "the five agentic tools live in the mobile delivery and nowhere else"

echo
echo "== No skill is listed without evidence in the body =="
# Every item in a \skillrow must also appear in that file's body text, otherwise
# it reads as padding to a reviewer. LaTeX escapes are normalised on BOTH sides
# so that e.g. "IBM~MQ" in the body matches "IBM MQ" in the skillrow.
#
# Certification/Languages/Awards rows are prose, not skills, and are skipped.
#
# ALLOW entries are legitimately implied rather than named -- each one is a
# deliberate choice, not an oversight.
ALLOW="javascript|sql|iso 27001|elk"

# Strip LaTeX noise from stdin.
norm() {
    sed -e 's/\\textasciitilde/~/g' -e 's/\\textbar//g' -e 's/\\&//g' \
        -e 's/\\%/%/g' -e 's/~//g' -e 's/\\//g'
}

# For .md, scan only the fenced ```text blocks (the copy-paste content).
# Editorial prose outside them discusses the rules; it is not a claim.
# (published_body is defined at the top of the file.)

orphans=()
for f in $ALL_FILES; do
    body=$(sed -e 's/\\skillrow{[^}]*}{[^}]*}//g' "$f" | norm | tr 'A-Z' 'a-z')
    rows=$(grep -oE '\\skillrow\{[^}]*\}\{[^}]*\}' "$f")

    # Collect parenthesised contents AND top-level comma items.
    items_all=""
    while IFS= read -r row; do
        [ -z "$row" ] && continue
        cat=$(echo "$row" | sed -E 's/^\\skillrow\{([^}]*)\}.*/\1/')
        # These rows are prose, not skills: they describe credentials, languages
        # and competitive-programming history, so there is nothing to evidence
        # them against in the body. "Competitive Programming"/"Programación
        # competitiva" replaced the old "Awards"/"Reconocimientos" label in the
        # 2026-10 pass: ACM-ICPC and Google Code Jam are programming-contest
        # credentials, and calling them corporate awards understated them.
        case "$cat" in
            Certification*|Certificación*|Languages|Idiomas|Competitive\ Programming|Programación\ competitiva) continue ;;
        esac
        raw=$(echo "$row" | sed -E 's/.*\{([^}]*)\}$/\1/')
        inner=$(echo "$raw" | grep -oE '\([^)]*\)' | tr -d '()' | tr ',' '\n')
        outer=$(echo "$raw" | sed -E 's/\([^)]*\)//g' | tr ',' '\n')
        items_all="$items_all$inner"$'\n'"$outer"$'\n'
    done <<< "$rows"

    while IFS= read -r item; do
        item=$(echo "$item" | norm | tr 'A-Z' 'a-z')
        item=$(echo "$item" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        [ ${#item} -lt 3 ] && continue
        echo "$item" | grep -qxE "$ALLOW" && continue

        # An item counts as evidenced if the whole phrase appears, OR -- for
        # descriptive multi-word entries like "on-call production support" or
        # "hexagonal architecture review" -- if any of its words does. Only
        # single-token tools get the strict treatment, which is the point of
        # this check: catching a fabricated tool in the skills row.
        if echo "$body" | grep -qF "$item"; then
            continue
        fi
        evidenced=0
        for w in $(echo "$item" | sed 's/[-_]/ /g'); do
            [ ${#w} -lt 4 ] && continue
            if echo "$body" | grep -qF "$w"; then evidenced=1; break; fi
        done
        [ "$evidenced" -eq 0 ] && orphans+=("$f: $item")
    done <<< "$items_all"
done

if [ ${#orphans[@]} -gt 0 ]; then
    fail "skills listed with no supporting evidence in the body:"
    for o in "${orphans[@]}"; do printf '       %s\n' "$o"; done
else
    pass "every listed skill is evidenced in the body"
fi

echo
if [ "$FAIL" -eq 0 ]; then
    printf '\033[32mAll profile invariants hold.\033[0m\n'
else
    printf '\033[31mOne or more invariants failed.\033[0m\n'
fi
exit $FAIL