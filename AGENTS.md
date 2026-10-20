# AGENTS.md — manual operativo del repositorio

Este archivo es el contrato entre quien edita el CV y el repositorio. Cada vez que cambie un
dato, un perfil o un proceso, **el proyecto completo tiene que quedar homologado**: los cuatro
perfiles, en los dos idiomas y en las dos variantes de diseño, tienen que contar **los mismos
hechos** con énfasis distinto, y nunca contradecirse.

Si una regla de este documento y el contenido del repositorio se contradicen, manda
`FACTS.md`: es la fuente única de verdad de **qué es cierto**. Este documento es la fuente
única de verdad de **cómo se edita**.

---

## 1. Qué es este repositorio

`main.tex` + `style.cls` generan un currículum LaTeX con **cuatro perfiles profesionales**
(DevOps, DevOps/SRE Lead, Full Stack, AI Engineer), **dos idiomas** (EN/ES) y **dos variantes
de diseño**:

| Variante | Para qué | Cómo se genera |
| --- | --- | --- |
| **ATS** (por defecto) | Portales de empleo y ATS. Una columna, sin gráficos, texto seleccionable. | `make all` |
| **Con diseño** (`DESIGN=1`) | Reclutador senior leyendo en pantalla. Banda oscura con foto, barra lateral gris y columna principal con línea de tiempo. | `make design` |

**Criterio de aceptación del layout: los 16 PDFs (4 perfiles × 2 idiomas × 2 variantes) deben
quedar en 2 páginas.** Es el motivo por el que el texto se recorta antes de añadirlo, y por el
que ninguna métrica, ningún empleador y ningún hecho confirmado se elimina para hacer espacio.

El perfil y el idioma se eligen en tiempo de compilación:

```bash
pdflatex -interaction=nonstopmode -jobname=... "\def\profile{ai}\def\lang{en}\input{main.tex}"
```

`main.tex` enruta con `\ifdefstring` anidados y un *fallback* silencioso a `lang/<lang>.tex`
(perfil DevOps). Un perfil nuevo necesita una rama más en ese enrutado.

**Detalles del layout con diseño que conviene conocer antes de tocar tipografía** (documentados
en `styles/styledesign.tex`):

- El archivo de contenido se **typeset dos veces**: una pasada "harvest" recoge los bloques
  `\sidecol` en cajas y otra imprime la columna principal. Sin la primera, la página 1 se
  imprimiría antes de llegar a Educación, que está al final del archivo.
- La **barra lateral es una caja que no se parte entre páginas**. Si su contenido no cabe, se
  pierde en silencio en el borde, sin error de compilación. Después de tocarla hay que medir
  su altura (ver §8).

---

## 2. Fuente de verdad y orden de edición

**El orden importa: se edita de arriba hacia abajo.**

| # | Archivo | Qué contiene | Cuándo se toca |
| --- | --- | --- | --- |
| 1 | `FACTS.md` | Empleadores, fechas, métricas, hechos confirmados, **frontera de lo declarable**, matriz de énfasis por perfil | **Primero**, siempre |
| 2 | `lang/{es,en}.tex`, `lang/lead/{es,en}.tex`, `lang/fullstack/{es,en}.tex`, `lang/ai/{es,en}.tex` | El contenido de los cuatro perfiles | Cuando cambia un hecho o una métrica |
| 3 | `scripts/check-profiles.sh` | Los invariantes mecánicos | Cuando cambia una regla, un nombre o un número |
| 4 | `README.md` | Estructura, targets, criterios | Cuando cambia la estructura del repo o el número de perfiles |
| 5 | `LinkedIn_perfil_AFRV_propuesta.md` | El copy publicable de LinkedIn (bloques ```text) | Cuando cambia un hecho que también se publica en LinkedIn |
| 6 | `.github/workflows/build-resume.yml` | CI: validación de commits, build, release | Cuando cambia el nombre de un PDF o se agrega un perfil |

Nunca al revés: si un perfil dice algo que `FACTS.md` no respalda, **el perfil está mal**, no
el archivo de hechos.

### La frontera editorial (`FACTS.md` §4) es dura

Antes de escribir una frase en cualquier archivo, comprobar contra `FACTS.md` §4 que la frase
no cae en la columna "No afirmar". Lo que **no** se puede afirmar:

- SLO, SLI, error budgets, objetivos de disponibilidad, postmortems o RCA.
- **Entrenamiento de modelos, fine-tuning, RAG, embeddings, bases vectoriales, MLOps, serving de
  modelos o integración con APIs de LLM.** La IA de este currículum es **aplicada y agéntica**:
  skills de Claude Code que enrutan una petición en lenguaje natural a un script determinista.
  El perfil de AI Engineer lo dice de forma explícita para que un reclutador de IA no lea una
  promesa de ML.
- Runbooks **en la experiencia laboral**. Los 12 runbooks que sí existen son los del contrato de
  entrega del trabajo móvil freelance, y solo se pueden mencionar dentro de ese bloque.
- Guardia 24/7 o en rotación: la guardia confirmada fue **dentro del horario laboral y sin
  rotación**.
- "Implementó arquitectura hexagonal": **la revisó**.
- Liderar Scrum, facilitar ceremonias o priorizar el backlog del equipo: era miembro del equipo.
- Auditoría o certificación ISO 27001: su rol fue **implementar y operar controles**.
- Nombres de tableros, wikis, canales y convenciones internas del empleador (`FACTS.md` §4c):
  se publica **la función**, no el artefacto.
- Nombres de los proyectos móviles, tienda de aplicaciones, descargas, usuarios, ingresos o
  pagos en producción.

`scripts/check-profiles.sh` convierte la mayoría de estas reglas en un fallo automático, pero
no todas: la honestidad editorial es responsabilidad de quien edita.

---

## 3. Matriz de homologación

Qué tocar cuando cambia cada tipo de dato. **Todas las filas aplican a los ocho archivos de
contenido** salvo donde se indica.

| Cambio | Dónde se registra | Qué hay que actualizar |
| --- | --- | --- |
| **Fecha** de un empleador o proyecto | `FACTS.md` §1 | Los 8 archivos de contenido (`\resumeentry`), con paridad EN/ES; el bloque `check_pair` de `check-profiles.sh` la verifica |
| **Métrica** (6 h → 1 h, 21 clústeres, 70 microservicios, 1,000 transacciones, 5,000 empleados…) | `FACTS.md` §2 | Los 8 archivos con el **mismo valor** en EN y ES; el `check_metric` correspondiente en `check-profiles.sh`; el bloque equivalente en `LinkedIn_perfil_AFRV_propuesta.md` |
| **Empleador** nuevo o cambio de rol | `FACTS.md` §1 y §3 | `\resumeentry` en los 8 perfiles; la lista de empleadores en `check-profiles.sh`; la sección de Experiencia de `LinkedIn_perfil_AFRV_propuesta.md` |
| **Herramienta nueva** (skill) | `FACTS.md` §3 | La fila de `\skillrow` correspondiente **y** al menos una mención en el cuerpo del perfil: una skill sin evidencia en el cuerpo se detecta como "huérfana" |
| **Hecho nuevo** (p. ej. el plugin de Claude Code) | `FACTS.md` §3 | Los 8 perfiles con el ángulo que le toca según la matriz de `FACTS.md` §5, **y** la matriz de énfasis si cambia el reparto entre perfiles |
| **Prohibición nueva** (algo que ya no se puede decir) | `FACTS.md` §4 | La tabla de `check-profiles.sh` (`FORBIDDEN`, `FORBIDDEN_ML`, `MOBILE_OVERCLAIM`, …) |
| **Perfil nuevo** | `FACTS.md` §1, §5 y §6 | Ver §6 de este documento |
| **Idioma nuevo** | — | Ver §7 de este documento |
| **Sección de proyectos independientes** | `FACTS.md` §3 (movil) | La sección y sus dos sub-entradas en los 8 perfiles, los marcadores `% mobile-begin` / `% mobile-end`, y el bloque equivalente de `check-profiles.sh` |
| **Copy de LinkedIn** | `FACTS.md` §4b | Los bloques ```text de `LinkedIn_perfil_AFRV_propuesta.md`; los marcadores `<!-- mobile-begin -->` / `<!-- mobile-end -->` delimitan el bloque móvil |
| **Nombre de un PDF** | — | `Makefile` (regla y target phony), `.github/workflows/build-resume.yml` (lista de compilación **y** lista de release), `README.md` (tabla de perfiles y de targets) |
| **Sección de skills** (nueva fila) | `FACTS.md` §5 | La `\skillrow` en los 8 perfiles, con la evidencia en el cuerpo |
| **Layout / tipografía** | — | `styles/styledesign.tex` o `style.cls`; después hay que **medir la barra lateral** (§8) y volver a comprobar las 2 páginas |

---

## 4. Checklist de cierre (obligatorio antes de commitear)

```bash
make check          # invariantes: debe salir verde
make docker         # los 8 PDFs ATS
make design-docker  # los 8 PDFs con diseño
for f in out/*.pdf; do echo "$f: $(pdfinfo "$f" | awk '/^Pages/{print $2}')"; done
```

Los 16 PDFs deben decir **2**. Checklist completo:

- [ ] `make check` en verde: *"All profile invariants hold."*
- [ ] `make docker` y `make design-docker` compilan sin errores.
- [ ] Los **16 PDFs** están en 2 páginas (`pdfinfo`).
- [ ] La **barra lateral** de los 8 PDFs con diseño no está recortada (ver §8).
- [ ] EN y ES de cada par dicen **las mismas cifras y las mismas fechas**.
- [ ] `FACTS.md` está actualizado **antes** que los perfiles.
- [ ] No hay identificadores internos ni afirmaciones prohibidas (§2).
- [ ] Toda skill listada en un `\skillrow` está respaldada en el cuerpo del perfil.
- [ ] Los bloques ```text de `LinkedIn_perfil_AFRV_propuesta.md` se han vuelto a pasar por
      `humanize.py` / `detect.py` (§8) y la tabla de resultados del documento está al día.
- [ ] `git status` no muestra artefactos: `out/` está en `.gitignore`, y no se suben `.aux`,
      `.log`, `.out`, `.fls` ni `.fdb_latexmk`.
- [ ] El diff se ha leído completo: los 8 perfiles narran los mismos hechos.

---

## 5. Convenciones de commit

El CI (`.github/workflows/build-resume.yml`) **valida el mensaje de cada commit** y, si es un
`feat`/`fix`/`!`, genera una release con los 16 PDFs adjuntos. Un mensaje inválido rompe el
build.

Formato: `<tipo>(<scope>): <descripción>`, con `!` antes de `:` para un breaking change.

Tipos válidos: `feat`, `fix`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`,
`test`, `revert`.

```bash
feat(cv): add AI Engineer profile and unify independent projects section
fix(cv): correct cluster count in the Lead ES profile
docs(cv): document the page-count acceptance criterion in AGENTS.md
```

**Nunca** añadir `Co-Authored-By: Claude Code` ni ninguna otra línea de coautoría a los
mensajes de commit de este repositorio, y quitar las que ya existieran.

`chore`, `docs` y `style` no disparan release: sirven para cambios que no tocan los PDFs.

---

## 6. Cómo agregar un perfil nuevo

Siete puntos. El ejemplo es el perfil `ai` (AI Engineer), que es el último que se agregó.

1. **`lang/<perfil>/en.tex` y `lang/<perfil>/es.tex`** — el contenido. Copiar la estructura de
   un perfil existente: `\resumeaddress`, `\resumejobtitle`, `\resumesummary`,
   `\resumesummaryheading`, `\makeheader`, `\sidecol` (skills), `\maincol` (experiencia),
   `\sidecol` (educación y certificación). **Cada bullet nuevo debe existir en `FACTS.md` §3.**
2. **`main.tex`** — una rama más en el enrutado `\ifdefstring` (anidada, con el mismo
   *fallback* silencioso a `lang/<lang>.tex`).
3. **`Makefile`** — dos reglas con el patrón `$(eval $(call PROFILE_RULE,<perfil>,en,<Nombre>,EN))`
   y `...es...`, los targets phony `<perfil>`, `<perfil>-en`, `<perfil>-es`, `<perfil>` en la
   cabecera y en el target `all`, y el perfil en la lista de `TEXSOURCES` del aviso de
   `make clean`.
4. **`scripts/check-profiles.sh`** — el archivo nuevo en `EN_FILES`, `ES_FILES` y `PAIRS`; y
   las reglas específicas del perfil (por ejemplo, el bloque que exige que el perfil IA
   declare `Claude Code`, `SKILL.md`, `4 skills` y `35 scripts`).
5. **`.github/workflows/build-resume.yml`** — los cuatro nombres de PDF (ATS y diseño, EN y ES)
   en la **lista de compilación** y en la **lista de `files:` de la release**.
6. **`README.md` y `FACTS.md`** — tabla de perfiles, árbol del repo, tabla de targets, número de
   PDFs; y en `FACTS.md`: §1 (perfil y fechas), §5 (columna de la matriz de énfasis) y §6
   (el número de PDFs).
7. **`LinkedIn_perfil_AFRV_propuesta.md`** — el titular correspondiente y, si el perfil tiene
   contenido publicable propio, su bloque.

Criterio de aceptación del perfil nuevo: **sus 4 PDFs en 2 páginas** y `make check` en verde.

---

## 7. Cómo agregar un idioma

1. Crear `lang/<perfil>/<idioma>.tex` con la traducción de `lang/<perfil>/es.tex`.
2. Registrar el idioma en `check-profiles.sh`: `EN_FILES`/`ES_FILES` pasan a ser listas
   groupings (`EN_FILES="lang/en.tex lang/fullstack/en.tex ..."`, `ES_FILES=...`) y el par
   nuevo entra en `PAIRS`.
3. La paridad de fechas se comprueba con el `norm_es` que traduce las abreviaturas de mes
   españolas al inglés; si el idioma nuevo usa otra forma, añadir su normalización.
4. El nombre del PDF (`..._AFRV_<IDIOMA>.pdf`) tiene que coincidir con la regla del `Makefile`
   y con las dos listas del CI.

El idioma se elige con `\def\lang{...}` en la línea de comandos de `pdflatex`; `main.tex` lo
interpola en la ruta del archivo (`lang/<perfil>/<idioma>.tex`).

---

## 8. Herramientas

| Para qué | Herramienta |
| --- | --- |
| Validar invariantes | `make check` (`scripts/check-profiles.sh`) |
| Compilar sin TeX local | `make docker`, `make design-docker` (imagen `texlive/texlive:TL2025-historic`) |
| Ver páginas | `pdfinfo out/<pdf>.pdf \| grep Pages` |
| Medir el relleno de página | `pdftotext -bbox` y la coordenada `yMax` de la última palabra; en el layout con diseño, el ancho de columna del sidebar (~190 pt) distingue la barra lateral de la columna principal |
| Revisar estilo del copy publicable | `li-human`: `humanize.py <bloque>.txt --report` (limpia y muestra qué cambió) y `detect.py <antes>.txt <después>.txt` (puntúa cinco señales) |
| Calificar el perfil | `li-profile`: rúbrica de 12 ítems sobre 100 puntos |

**Reglas de uso de `li-human` en este repo:**

- **`humanize.py` no se pasa nunca por un `.tex`**: reescribiría LaTeX (`---` → coma, comillas
  tipográficas, etc.). Sobre `.tex` solo se usa `detect.py` como medidor.
- Sobre `LinkedIn_perfil_AFRV_propuesta.md` sí se usa el limpiador, pero **bloque a bloque**:
  se extraen los bloques ```text, se revisa cada cambio a mano y se aplican solo los que no
  alteren el significado ni el tono.
- No se persiguen contracciones ni pronombres en primera persona: en un currículum en tercera
  persona, la puntuación de `VOICE` de `detect.py` es un **falso positivo**.

**Sobre la barra lateral con diseño:** para comprobar que no se recorta, se verifica que el
último elemento de la barra (por ejemplo "Competitive Programming" / "Programación competitiva")
aparece en el PDF con `pdftotext`. Si falta, la barra se pasó de largo: hay que acortar el
resumen o las filas de skills de ese perfil.

---

## 9. Mapa rápido de archivos

| Ruta | Qué es |
| --- | --- |
| `main.tex` | Punto de entrada. Datos personales + enrutado de perfil/idioma |
| `style.cls` | Clase ATS de una columna; carga `styles/styledesign.tex` con la opción `design` |
| `styles/styledesign.tex` | Variante con diseño: banda, barra lateral, línea de tiempo |
| `lang/es.tex`, `lang/en.tex` | Perfil DevOps |
| `lang/lead/es.tex`, `lang/lead/en.tex` | Perfil DevOps/SRE Lead |
| `lang/fullstack/es.tex`, `lang/fullstack/en.tex` | Perfil Full Stack |
| `lang/ai/es.tex`, `lang/ai/en.tex` | Perfil AI Engineer |
| `FACTS.md` | **Fuente única de verdad**: hechos, métricas, frontera de lo declarable, matriz de énfasis |
| `scripts/check-profiles.sh` | Los invariantes mecánicos entre los 8 perfiles |
| `LinkedIn_perfil_AFRV_propuesta.md` | Copy publicable de LinkedIn (bloques ```text) |
| `RECRUITER_REVIEW.md` | Calificación de cada perfil como reclutador senior, con las correcciones aplicadas |
| `Makefile` | Targets de compilación local y vía Docker |
| `.github/workflows/build-resume.yml` | CI: valida commits, compila, publica la release con los 16 PDFs |
