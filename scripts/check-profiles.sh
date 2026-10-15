#!/usr/bin/env bash
#
# check-profiles.sh -- invariant checks across every resume profile.
#
# The repo compiles the same career facts into six content files (3 profiles x
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

EN_FILES="lang/en.tex lang/fullstack/en.tex lang/lead/en.tex"
ES_FILES="lang/es.tex lang/fullstack/es.tex lang/lead/es.tex"
ALL_FILES="$EN_FILES $ES_FILES"
# Copy-paste blocks that get published verbatim -- same claim rules apply.
PUBLISHED="LinkedIn_perfil_AFRV_propuesta.md"

# Profile pairs: EN and ES must agree on employers, dates and metrics.
PAIRS="lang/en.tex:lang/es.tex
lang/fullstack/en.tex:lang/fullstack/es.tex
lang/lead/en.tex:lang/lead/es.tex"

# For .md, scan only the fenced ```text blocks (the copy-paste content).
# Editorial prose outside them discusses the rules; it is not a claim.
published_body() {
    if [ "${1##*.}" = "md" ]; then
        awk '/^```text$/{f=1;next} /^```$/{f=0;next} f' "$1"
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
# Scope: the six content files only. FACTS.md documents this rename on purpose.
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
FORBIDDEN="error budget|post-?mortem|root cause analysis|postmortem|\brunbooks?\b|\bSLIs?\b|error budgets"
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -oiE "$FORBIDDEN" | sort -u | tr '\n' ' ')
    [ -n "$hits" ] && fail "$f contains unconfirmed terms: $hits"
done
pass "no SLO/SLI, error budget, postmortem or runbook claims"

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
check_metric "10 CI/CD pipelines"          "10 Azure DevOps CI/CD"   "10 pipelines de CI/CD"
check_metric "6h -> 1h deployment"         "6 hours to 1 hour"        "6 horas a 1 hora"
check_metric "9 production clusters"       "9 production clusters"    "9 clústeres de producción"
check_metric "60 -> 30 min detection"      "60 to 30 minutes"         "60 a 30 minutos"
check_metric "2h -> 20 min provisioning"   "2 hours to 20 minutes"    "2 horas a 20 minutos"
check_metric "~1,000 transactions/day"     "1(,|\\{,\\})000 transactions" "1(,|\\{,\\})000 transacciones"
check_metric "5,000 employees"             "5(,|\\{,\\})000 employees" "5(,|\\{,\\})000 empleados"
check_metric "1-day ServiceNow SLA"        "1-day (ServiceNow )?SLA"   "SLA de 1 día"
pass "core metrics consistent across all six profiles"

echo
echo "== ISO 27001 role is controls, not audit or certification =="
for f in $ALL_FILES $PUBLISHED; do
    [ -f "$f" ] || continue
    hits=$(published_body "$f" | grep -iE "ISO.{0,40}(auditor|certif)|(auditor|certif).{0,40}ISO")
    [ -n "$hits" ] && fail "$f ties ISO 27001 to audit/certification -- his role was implementing controls"
done
pass "no audit/certification claim attached to ISO 27001"

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
        case "$cat" in
            Certification*|Certificación*|Languages|Idiomas|Awards|Reconocimientos) continue ;;
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