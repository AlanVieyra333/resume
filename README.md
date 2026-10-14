# Resume — Alan Fernando Rincón Vieyra

Repositorio LaTeX que genera el CV de **Alan Fernando Rincón Vieyra** en dos perfiles profesionales y dos idiomas. La compilación produce cuatro PDFs ATS-friendly (una columna, sin gráficos de maquetación, texto seleccionable) listos para enviar a bolsas de trabajo, portales de empleo y Applicant Tracking Systems.

> Basado en el template ATS-friendly de [Carmine Spagnuolo](https://github.com/carminesagnuolo/CV), redistribuido bajo MIT. Ver [LICENSE](LICENSE).

## Perfiles generados

| Perfil | Inglés | Español |
| --- | --- | --- |
| **DevOps Engineer** | [Resume_DevOps_AFRV_EN.pdf](Resume_DevOps_AFRV_EN.pdf) | [Resume_DevOps_AFRV_ES.pdf](Resume_DevOps_AFRV_ES.pdf) |
| **Senior Full Stack Software Engineer** | [Resume_FullStack_AFRV_EN.pdf](Resume_FullStack_AFRV_EN.pdf) | [Resume_FullStack_AFRV_ES.pdf](Resume_FullStack_AFRV_ES.pdf) |

Cada PDF se compila desde el mismo `main.tex` con un `\def\profile{...}\def\lang{...}` distinto, lo que permite mantener una sola clase (`style.cls`) y cuatro bloques de contenido aislados.

## Estructura del repositorio

```
.
├── main.tex                    # Punto de entrada: enruta a lang/{es,en}.tex o lang/fullstack/{es,en}.tex
├── style.cls                   # Clase ATS-friendly (single column, sans-serif, hyperref)
├── Makefile                    # Targets de compilación local y vía Docker
├── profile.jpg                 # Foto de perfil (no se usa en el PDF — es ATS-safe)
├── LICENSE                     # MIT (template original)
├── LinkedIn_perfil_AFRV_propuesta.md
│                               # Borrador de copy para LinkedIn (no se compila)
├── lang/
│   ├── es.tex                  # Perfil DevOps, español
│   ├── en.tex                  # Perfil DevOps, inglés
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
| `make all` | Compila los cuatro PDFs (DevOps + Fullstack, ES + EN). |
| `make devops` / `make devops-es` / `make devops-en` | Solo el perfil DevOps. |
| `make fullstack` / `make fullstack-es` / `make fullstack-en` | Solo el perfil Full Stack. |
| `make docker` | Compila todo dentro del contenedor `texlive/texlive:TL2025-historic`, sin instalar TeX localmente. |
| `make clean` | Borra logs, `.aux`, `.out`, `.fls`, `.fdb_latexmk` y los PDFs generados. |

### Ejemplos rápidos

```bash
# Solo el CV DevOps en español
make devops-es

# Los cuatro PDFs, sin TeX local (Docker)
make docker

# Limpiar artefactos antes de un commit
make clean
```

## Cómo editar el contenido

**Datos personales** (nombre, dirección, contacto, redes) — solo se cambian en un sitio: [main.tex](main.tex), bloque `PERSONAL INFORMATION`. Estos campos son language-independent y la clase los renderiza en ambos idiomas.

**Resumen, skills, experiencia y proyectos** — se editan en los archivos de `lang/`:

- [lang/es.tex](lang/es.tex) y [lang/en.tex](lang/en.tex) — perfil DevOps, español e inglés.
- [lang/fullstack/es.tex](lang/fullstack/es.tex) y [lang/fullstack/en.tex](lang/fullstack/en.tex) — perfil Full Stack, español e inglés.

Cada archivo sigue la misma estructura (`\resumesummary`, `\skillrow`, `\resumeentry`, secciones con `\section*{...}`). Cuando actualices métricas o descripciones, mantén las cifras y el alcance alineados entre los dos idiomas — el CI no valida este detalle y un desajuste se nota rápido en una entrevista.

Las macros que vas a usar:

| Macro | Uso |
| --- | --- |
| `\resumeentry{Título}{Organización}{Fechas}{Ubicación}` | Cabecera de experiencia o educación. |
| `\skillrow{Categoría}{items}` | Una fila de skills (formato `Categoría: item, item`). |
| `\section*{...}` | Sección sin numerar (Profesional Experience, Skills, etc.). |

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