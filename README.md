# Resume — Alan Fernando Rincón Vieyra

Repositorio LaTeX que genera el CV de **Alan Fernando Rincón Vieyra** en **tres perfiles profesionales y dos idiomas**, en **dos variantes de diseño** (12 PDFs en total).

El mismo contenido se compila de dos formas, porque son dos lecturas distintas del mismo currículum:

| Variante | Para qué | Cómo se genera |
| --- | --- | --- |
| **ATS** (por defecto) | Portales de empleo y Applicant Tracking Systems. Una columna, sin gráficos de maquetación, texto seleccionable. | `make` |
| **Con diseño** (`DESIGN=1`) | Reclutador senior leyendo en pantalla. Banda oscura con foto, barra lateral gris y columna principal con línea de tiempo. | `make design` |

Ambas variantes salen del **mismo contenido** (`lang/*.tex`); lo único que cambia es la capa visual. No hay que mantener dos currículums.

> Basado en el template ATS-friendly de [Carmine Spagnuolo](https://github.com/carminesagnuolo/CV), redistribuido bajo MIT. Ver [LICENSE](LICENSE).

## Perfiles generados

| Perfil | Enfoque | Inglés | Español |
| --- | --- | --- | --- |
| **DevOps Engineer** | Cloud e infraestructura: AWS, Terraform, CI/CD | [Resume_DevOps_AFRV_EN.pdf](out/Resume_DevOps_AFRV_EN.pdf) | [Resume_DevOps_AFRV_ES.pdf](out/Resume_DevOps_AFRV_ES.pdf) |
| **DevOps/SRE Engineer Lead** | Deuda técnica, estándares y cumplimiento | [Resume_DevOpsLead_AFRV_EN.pdf](out/Resume_DevOpsLead_AFRV_EN.pdf) | [Resume_DevOpsLead_AFRV_ES.pdf](out/Resume_DevOpsLead_AFRV_ES.pdf) |
| **Senior Full Stack Software Engineer** | Ownership de entrega y arquitectura de microservicios | [Resume_FullStack_AFRV_EN.pdf](out/Resume_FullStack_AFRV_EN.pdf) | [Resume_FullStack_AFRV_ES.pdf](out/Resume_FullStack_AFRV_ES.pdf) |

Cada PDF se compila desde el mismo `main.tex` con un `\def\profile{...}\def\lang{...}` distinto, lo que permite mantener una sola clase (`style.cls`) y seis bloques de contenido aislados (3 perfiles × 2 idiomas). Añadiendo `\def\design{1}` se obtiene la variante con diseño, cuyo nombre lleva el sufijo `_DESIGN` y convive en `out/` con la ATS.

## Las dos variantes de diseño

Ambas se construyen desde los mismos seis archivos de `lang/`. El contenido se marca con dos envoltorios que no hacen nada en la variante ATS:

```latex
\sidecol{ ... }   % barra lateral gris (con diseño) / texto normal (ATS)
\maincol{ ... }   % columna principal con línea de tiempo (con diseño) / normal (ATS)
```

Con `DESIGN=1`, `style.cls` carga [styles/styledesign.tex](styles/styledesign.tex), que redefine `\makeheader`, `\resumeentry` y `\skillrow`, y pinta desde el hook `shipout` la banda del encabezado, el panel gris, la foto circular y la línea de tiempo.

Dos detalles que conviene conocer antes de tocar ese archivo:

- **El archivo de contenido se typeset dos veces.** La primera pasada ("harvest") recoge los bloques `\sidecol` en cajas; la segunda imprime la columna principal. Sin la primera pasada, LaTeX enviaría la página 1 a imprimir antes de llegar a Educación — que está al final del archivo — y la barra lateral saldría incompleta.
- **La barra lateral es una caja que no se parte entre páginas.** Si su contenido no cabe en la página 1, se pierde en silencio en lugar de continuar. Al tocar tipografía conviene volver a medirla.

## Estructura del repositorio

```
.
├── main.tex                    # Punto de entrada: enruta a lang/{es,en}.tex, lang/lead/ o lang/fullstack/
├── style.cls                   # Clase base (ATS single column) + opción de clase `design`
├── styles/
│   └── styledesign.tex         # Variante con diseño (banda, barra lateral, línea de tiempo)
├── Makefile                    # Targets de compilación local y vía Docker
├── profile.png                 # Foto de perfil (solo se usa en la variante con diseño)
├── out/                        # PDFs generados (gitignored; poblado por `make all`)
├── FACTS.md                    # Fuente única de verdad: hechos confirmados, métricas y límites de lo declarable
├── LICENSE                     # MIT (template original)
├── scripts/
│   └── check-profiles.sh       # Verifica invariantes entre los 6 perfiles (make check)
├── LinkedIn_perfil_AFRV_propuesta.md
│                               # Borrador de copy para LinkedIn (no se compila)
├── lang/
│   ├── es.tex                  # Perfil DevOps, español
│   ├── en.tex                  # Perfil DevOps, inglés
│   ├── lead/
│   │   ├── es.tex              # Perfil DevOps/SRE Lead, español
│   │   └── en.tex              # Perfil DevOps/SRE Lead, inglés
│   └── fullstack/
│       ├── es.tex              # Perfil Full Stack, español
│       └── en.tex              # Perfil Full Stack, inglés
└── .github/workflows/
    └── build-resume.yml        # CI: build + release por Conventional Commits
```

## Compilación

### Requisitos

- Una distribución TeX Live reciente (`pdflatex` + `latexmk`). En macOS: `brew install --cask mactex-no-gui`. En Linux: el paquete `texlive-full` o `texlive-base` + `latexmk`.
- Make.

### Targets disponibles

| Comando | Resultado |
| --- | --- |
| `make` | Compila el perfil por defecto (`devops`) en ambos idiomas. |
| `make all` | Compila los seis PDFs ATS (DevOps + DevOps Lead + Fullstack, ES + EN). |
| `make design` | Compila los seis PDFs **con diseño** (sufijo `_DESIGN`). |
| `make DESIGN=1 <target>` | Compila ese target concreto con diseño (p. ej. `make DESIGN=1 devops-es`). |
| `make devops` / `make devops-es` / `make devops-en` | Solo el perfil DevOps. |
| `make lead` / `make lead-es` / `make lead-en` | Solo el perfil DevOps/SRE Lead. |
| `make fullstack` / `make fullstack-es` / `make fullstack-en` | Solo el perfil Full Stack. |
| `make docker` | Compila todo (ATS) dentro del contenedor `texlive/texlive:TL2025-historic`, sin instalar TeX localmente. |
| `make design-docker` | Igual, pero con la variante con diseño. |
| `make check` | Verifica los invariantes entre perfiles sin compilar. |
| `make clean` | Borra `out/`, los PDFs generados, y los intermedios de LaTeX (`.log`, `.aux`, `.out`, `.fls`, `.fdb_latexmk`). |

### Ejemplos rápidos

```bash
# Solo el CV DevOps en español
make devops-es

# Los seis PDFs, sin TeX local (Docker)
make docker

# Limpiar artefactos antes de un commit
make clean
```

## Homologación entre perfiles

Los seis archivos de contenido cuentan **los mismos hechos con énfasis distinto**, y no deben contradecirse. La fuente de verdad es [FACTS.md](FACTS.md): empleadores, fechas, métricas exactas, qué está confirmado y qué no se puede declarar.

`scripts/check-profiles.sh` (también en el CI, antes de compilar) falla si algún perfil:

- usa `Citibanamex` en lugar de `Banamex`;
- declara SLO/SLI, error budgets, postmortems o runbooks (no confirmados);
- afirma haber **implementado** la arquitectura hexagonal (la revisó);
- vincula ISO 27001 con auditorías o certificaciones (su rol fue implementar y operar controles);
- lista una herramienta en las skills que no aparece respaldada en la experiencia;
- cambia una fecha o una métrica respecto a su hermano del otro idioma.

Cuando cambies un dato, actualiza **FACTS.md primero** y después los perfiles. Cada PDF ATS debe quedar en **2 páginas**; los de la variante con diseño pueden llegar a 3.

## Cómo editar el contenido

**Datos personales** (nombre, dirección, contacto, redes) — solo se cambian en un sitio: [main.tex](main.tex), bloque `PERSONAL INFORMATION`. Estos campos son language-independent y la clase los renderiza en ambos idiomas.

**Resumen, skills, experiencia y proyectos** — se editan en los archivos de `lang/`:

- [lang/es.tex](lang/es.tex) y [lang/en.tex](lang/en.tex) — perfil DevOps, español e inglés.
- [lang/lead/es.tex](lang/lead/es.tex) y [lang/lead/en.tex](lang/lead/en.tex) — perfil DevOps/SRE Lead, español e inglés.
- [lang/fullstack/es.tex](lang/fullstack/es.tex) y [lang/fullstack/en.tex](lang/fullstack/en.tex) — perfil Full Stack, español e inglés.

Cada archivo sigue la misma estructura (`\resumesummary`, `\skillrow`, `\resumeentry`, secciones con `\section*{...}`). Cuando actualices métricas o descripciones, mantén las cifras y el alcance alineados entre los dos idiomas — el CI no valida este detalle y un desajuste se nota rápido en una entrevista.

Las macros que vas a usar:

| Macro | Uso |
| --- | --- |
| `\resumeentry{Título}{Organización}{Fechas}{Ubicación}` | Cabecera de experiencia o educación. |
| `\skillrow{Categoría}{items}` | Una fila de skills (formato `Categoría: item, item`). |
| `\section*{...}` | Sección sin numerar (Profesional Experience, Skills, etc.). |
| `\sidecol{...}` / `\maincol{...}` | Envolturas de columna. En la variante ATS son no-ops; con diseño mandan el bloque a la barra lateral o a la columna principal. |
| `\resumesummaryheading{Título}` | Encabezado del resumen en la barra lateral (`About`, `Sobre mí`). No-op en ATS. |

Los proyectos destacados pueden usar el mismo `\resumeentry` que las posiciones de experiencia, lo que les da el mismo tratamiento tipográfico (fechas y ubicación alineadas a la derecha).

## Versionado y releases

El workflow de GitHub Actions ([.github/workflows/build-resume.yml](.github/workflows/build-resume.yml)) se dispara en cada `push` a `master` y:

1. Valida que cada commit siga **Conventional Commits**.
2. Decide el bump (`major` / `minor` / `patch`) según el tipo: `feat` → minor, `fix` → patch, `!` o `BREAKING CHANGE:` → major.
3. Crea (o reutiliza) el tag `vX.Y.Z` y publica un GitHub Release con los PDFs adjuntos y un changelog generado a partir de los mensajes.

Tipos válidos: `feat`, `fix`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`, `revert`.

Ejemplos de mensajes que el CI acepta:

```bash
feat: add Helm charts experience to skills and Veradat role
fix(es): correct typo in Subcontracting Law project description
refactor!: rename cv references to resume across project
docs: clarify Docker build target in README
```

Si un commit no sigue el formato, el workflow falla y no se genera release. Para saltarse el release sin saltarse la validación, usar tipos como `chore`, `docs` o `style`.

## Licencia

[MIT](LICENSE) — Copyright (c) 2016 Carmine Spagnuolo (template original).