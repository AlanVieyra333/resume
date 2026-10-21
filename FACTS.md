# FACTS — fuente única de verdad de los perfiles del CV

Este archivo es la referencia para **qué es cierto** y **qué no se puede afirmar** en
los ocho archivos de contenido del CV. Los perfiles lo citan en su cabecera.

Cuando cambies un dato, actualízalo aquí **primero** y luego en los perfiles.
`scripts/check-profiles.sh` verifica mecánicamente varios de estos invariantes.

---

## 1. Empleadores y fechas (invariante — idéntico en los 4 perfiles × 2 idiomas)

| Empleador | Cliente | Rol | Fechas | Ubicación |
|---|---|---|---|---|
| Veradat Smart Network S.A. de C.V. | — | DevOps Engineer | Ago 2024 – Oct 2026 | Ciudad de México |
| IDS Comercial S.A. de C.V. | Banamex | Fullstack + DevOps Engineer | Ene 2021 – Ago 2024 | México, remoto |
| Proyecto continuo (GLOBAL HITSS → Everis) | Telcel | Fullstack Software Engineer | Jul 2018 – Dic 2020 | Ciudad de México |
| GDP administración S de RL de CV (Grupo de la Parra) | — | Freelance, líder técnico | Jun 2021 – Dic 2021 | Ciudad de México |
| Proyectos freelance e independientes | — | React Native Developer / Mobile Project Lead | 2023 – 2026 | Ciudad de México |

> **El freelance se solapa con IDS Comercial (Ene 2021 – Ago 2024).** Fechas confirmadas por
> Alan el 2026-10: junio–diciembre de 2021. Fue trabajo paralelo mientras estaba contratado
> con Banamex; ambos periodos se publican tal cual. Si un reclutador pregunta, la respuesta
> es trabajo freelance simultáneo, no una discontinuidad laboral.

> **El desarrollo móvil freelance se solapa con Veradat (Ago 2024 – Oct 2026).** Alan confirmó
> el 2026-10 que el trabajo móvil corre en paralelo a la relación laboral con Veradat. Se publica
> dentro de la sección de **proyectos independientes** ("Selected & Independent Projects" /
> "Proyectos Destacados e Independientes"), y **no** se fusiona con Veradat ni se presenta como un
> puesto employed. Es trabajo paralelo, declarado como tal.
>
> **Periodo del trabajo móvil: 2023 – 2026, solo con años.** Alan confirmó el 2026-10-19 que lleva
> usando React Native desde años anteriores, y pidió que el bloque se feche **sin meses**
> (`2023 -- 2026`, idéntico en EN y ES). Antes se publicaba como "Ago 2026 – Actualidad".

> **GLOBAL HITSS: Jul 2018 – Sep 2019; Everis: Sep 2019 – Dic 2020.**
> Cambio de consultora a mitad del proyecto continuo.

Eliminado de los cuatro perfiles en la revisión 2026-10: **Nova Solutions / Banco Multiva**
(Frontend Jr., Mar 2017 – May 2018) y **CINVESTAV** (maestría no concluida, sin grado).

---

## 2. Métricas (invariante — mismo valor en EN y ES)

| Métrica | Valor | Dónde |
|---|---|---|
| Pipelines de CI/CD mantenidos | 20 | Veradat |
| Procesos automatizados con shell scripting | 20 | Veradat |
| Procesos automatizados con shell scripting | 10 | IDS Comercial (Banamex) |
| Total de procesos automatizados con shell scripting | 30 (20 + 10) | Veradat + IDS Comercial |
| Equipos atendidos por esos pipelines | 3 (frontend, backend, QA) | Veradat |
| Despliegue del conjunto completo | 70 microservicios | Veradat |
| Reducción de tiempo de despliegue | 6 h → 1 h (≈83 %) | Veradat |
| Clústeres de preproducción | 21 (9 QA + 4 DEV + 4 INTGR + 4 Certificación) | Veradat |
| Distribución por plataforma | Kubernetes: 9 QA + 4 Certificación; OpenShift: 4 DEV + 4 INTGR | Veradat |
| Detección de incidentes | 60 min → 30 min (50 %) | Veradat |
| Servidores aprovisionados con Ansible | 10 | Veradat |
| Aprovisionamiento | 2 h → 20 min (≈83 %) | Veradat |
| Experiencia Python / Go | confirmada (años no publicados) | Veradat |
| Experiencia Claude Code | confirmada (tiempo no publicado) | Veradat |
| Plugin de Claude Code para la plataforma | 4 skills · 35 scripts Python (~10,800 líneas) · ~3,200 líneas de `SKILL.md` | Veradat |
| Microservicios en producción | 10 | Banamex |
| Transacciones diarias por sucursal | ≈1,000 | Banamex |
| Resolución de incidentes QA | 2–3 h promedio; hasta 1 semana en casos complejos | Banamex |
| SLA de tickets de infraestructura | 1 día (ServiceNow) | Banamex |
| Fuerza laboral cubierta por el sistema | 5,000 empleados | Freelance |
| Contrato de entrega del trabajo móvil | 12 ADRs, 20 specs, 12 runbooks | Freelance móvil |
| Workflows de CI/CD del trabajo móvil | 6 (GitHub Actions) | Freelance móvil |
| Archivos de prueba del trabajo móvil | 95 (Lead/DevOps/AI) · 124 (Full Stack) | Freelance móvil |
| Cobertura de pruebas (Full Stack) | 85.9 % sentencias · 95.2 % funciones | Freelance móvil |
| Pasos del pipeline de estimación (Ley 73) | 8 funciones puras | Freelance móvil |
| Semanas cotizadas promediadas | 250 últimas | Freelance móvil |

---

## 3. Hechos confirmados por RECORD (no deducidos)

### Veradat
- Diseñó y mantiene 20 pipelines de CI/CD en Azure DevOps para 3 equipos.
  - **Corrección 2026-10-19 (confirmada por Alan):** la cifra real es de **~20 pipelines**
    (publicada como 20); las versiones anteriores declaraban 10. Los tres equipos y las demás
    métricas del puesto no cambian.
- Charts de Helm como **estándar de despliegue**, adoptado por los 3 equipos.
- Administra **21 clústeres de preproducción**, todos de preproducción (ninguno de producción):
  - **9 en QA sobre Kubernetes**
  - **4 en DEV sobre OpenShift**
  - **4 en INTGR sobre OpenShift**
  - **4 en Certificación sobre Kubernetes**
- Readiness/liveness probes en los clústeres de Kubernetes; monitoreo y alertas con
  **Elastic Stack** en los 9 clústeres de QA.
- **Corrección 2026-10-18 (confirmada por Alan):** las versiones anteriores publicaban
  "9 clústeres de QA (8 Kubernetes, 1 OpenShift)" y, aparte, "12 de preproducción
  (4 DEV + 4 INTGR + 4 Certificación)". Ambas cifras eran incorrectas. El desglose real
  es 21 clústeres, **todos de preproducción**, y QA corre 100 % en Kubernetes (no OpenShift).
  Además DEV e INTGR corren sobre OpenShift, no sobre Kubernetes.
- Provisioning en AWS y Azure con Terraform; servicios de AWS usados: **EC2, S3, VPC, Security Groups, IAM, RDS, CloudWatch y Route 53**; gestión de secretos. *(Confirmado por Alan el 2026-10-16; antes del ajuste el CV solo declaraba Route 53 e IAM.)*
- **Backups y rollbacks de bases de datos PostgreSQL y Oracle** que soportan los 70 microservicios,
  asegurando la recuperabilidad durante despliegues y respuesta a incidentes. *(Confirmado por Alan el
  2026-10-16.)*
- Automatización con Ansible en servidores Linux.
- **Automatizó 20 procesos con shell scripting** (scripts de shell para tareas de operación).
  *(Confirmado por Alan el 2026-10-19. El total es de 30 procesos: 20 en Veradat y 10 en
  IDS Comercial. En el banner se publica como "+30" porque las cifras se redondean hacia abajo
  a múltiplo de diez.)*
- Scripts de automatización/integración en Python y Go. (Los años de uso no se publican en
  el CV: el resto de herramientas se lista solo por nombre, sin tiempo de experiencia, y Alan
  pidió en 2026-10 mantener ese mismo formato para no destacar Python/Go/Claude Code con un
  baremo distinto al resto.)
- Claude Code como asistente de desarrollo.
- **Plugin de Claude Code para la plataforma Veradat** (confirmado por Alan el 2026-10-19 y
  verificado sobre el código de la suite):
  - **4 skills**: `devops-ado` (Azure DevOps), `devops-aws` (AWS Secrets Manager y Security
    Groups), `devops-k8s` (operación de Kubernetes/OpenShift) y `devops-snyk` (reportes de
    vulnerabilidades de Snyk).
  - **35 scripts en Python** (~10,800 líneas) y **~3,200 líneas de documentación `SKILL.md`**,
    más un script que **genera automáticamente el índice de capacidades** a partir del frontmatter.
  - Cada skill **detecta la intención en lenguaje natural** y la ejecuta con un script
    determinista: es enrutado de peticiones a scripts, no una llamada a un modelo.
  - Operaciones reales de plataforma ejecutadas con ellos: validación de releases, creación de
    work items, gestión de tags, redespliegues de nodos, regeneración de imágenes base, obtención
    de secretos, auditorías de configuración y reportes de Snyk.
  - **El número de capacidades no se publica**: el índice autogenerado dice 17 y el frontmatter
    del `SKILL.md` dice 18; no hay una cifra única verificable.
  - Los identificadores internos de esa suite (board, wiki, bastiones, orgs y nombres de
    agentes) se generalizan según la §4c: se publica la función, no el artefacto.
- Remediación de vulnerabilidades con SonarQube Cloud, Snyk y Mend.
- **Arquitectura hexagonal: la REVISÓ. No la implementó.** Desacopla cada microservicio de
  Postgres, Oracle, RabbitMQ, Kafka, IBM MQ y SQS.
- **Generó la imagen Docker para cada combinación tecnológica** que cada microservicio requiere.
- **Implementó y operó controles ISO 27001** (secretos, control de acceso en nube, escaneo de
  dependencias).
- **Acompaña/mentorea a 10 ingenieros** de los equipos frontend, backend y QA de Veradat:
  revisiones de código y diseño, decisiones técnicas, incorporación de nuevos miembros.
  *(Cifra corregida el 2026-10: la versión anterior decía "3 ingenieros" — eran 3 equipos; el
  total de personas mentoreadas es 10, distribuidas entre los tres equipos.)*
- **Cubre guardia (on-call) para incidentes en producción, dentro del horario laboral y sin
  rotación.** *(Confirmado el 2026-10. NO es una guardia 24/7. El CV lo dice explícitamente para
  no invitar a una pregunta de entrevista que no pueda responder limpiamente.)*
- **Trabaja dentro de Scrum** como miembro del equipo.
- **Planea y prioriza actividades de infraestructura en Microsoft Project, por sprint/iteración.**
- **Coordina la interlocución técnica con stakeholders del cliente y entre los 3 equipos**
  (frontend, backend, QA) en Veradat. Con el cliente (área de seguridad), redacta notificaciones
  formales de vulnerabilidades a partir de reportes de Snyk con un formato recurrente: tabla de
  hallazgo, plan de remediación y firma. Entre los equipos, opera Azure DevOps como canal de
  coordinación: dashboards y boards (pases de QA, seguimiento de sprint, etiquetado de releases)
  y una wiki compartida como canal asincrónico entre equipos.
  > Los identificadores internos reales (board 'Cambios de Ambiente - DevOps', board 'Tortugas
  > Furiosas', tags `*-qa`/`*-prod`, wiki 'Versiones de imágenes base') quedan registrados aquí
  > como hechos, pero **no se publican** en los perfiles: son artefactos de la operación interna
  > de un cliente y no le dicen nada a un reclutador. Ver sección 4c.
- Las seis tecnologías (Postgres, Oracle, RabbitMQ, Kafka, IBM MQ, SQS) están presentes también en
  Banamex.

### Banamex (vía IDS Comercial)
- 10 microservicios Java/Spring Cloud en producción.
- **POM padre multimódulo de Maven** + gestión compartida de dependencias.
- **Se apegó a los controles ISO 27001** durante toda la colaboración (no fue quien los implementó; sostuvo la operación).
- Pipelines con **Jenkins** (no usó Azure DevOps en este puesto; Azure DevOps es la plataforma de
  CI/CD de Veradat). React/Node.js/TypeScript; esquemas Oracle.
- Splunk en producción; **atención principal de tickets de infraestructura en ServiceNow bajo SLA de 1 día, con revisión de logs (troubleshooting) y escalamiento de incidentes al área correspondiente**.
- **Automatizó 10 procesos con shell scripting** (scripts de shell para tareas de operación).
  *(Confirmado por Alan el 2026-10-19.)*
- Scrum se usó mínimamente; el trabajo fue mayoritariamente operativo (tickets, logs, incidentes).
- **No usó Microsoft Project** en este puesto. Microsoft Project aplica solo a Veradat.

### Telcel (proyecto continuo GLOBAL HITSS → Everis)
- **Migración de microservicios desde un servidor de aplicaciones Tomcat a OpenShift**
  *(confirmado por Alan el 2026-10-16; antes del ajuste el CV solo declaraba "contenierización con Docker sobre Kubernetes").*
- Capa de integración con Java, Spring Cloud y JPA que tradujo protocolos legados a APIs REST.
- CI/CD y contenerización con Docker sobre Kubernetes. Bash para procesos operativos.
  Repositorios de código y artefactos con GitHub y Nexus.
- **También confirmado por Alan el 2026-10: microservicios y funcionalidades frontend con
  React, Node.js y TypeScript, y administración de bases de datos Oracle.** Publicados solo en el
  perfil Full Stack (EN/ES), donde el stack frontend es el ángulo; en DevOps y Lead se omiten para
  no inflar el bloque de Telcel, que ahí pesa como contexto de CI/CD y Kubernetes.
- **Versiones de Java** (confirmado el 2026-10): **Java 8 y 11 en Telcel; Java 21 en Veradat.**
  No se publican en los perfiles: la certificación de Oracle es de 2013 y publicar versiones
  modernas junto a ella invita la pregunta "¿entonces la certificación sigue vigente?". Queda
  registrado aquí para responderla en entrevista o para una futura certificación de Java 21.

### Freelance (Grupo de la Parra)
- **Lideró** el diseño técnico y la arquitectura end-to-end.
- Motor de auditoría de cumplimiento de la Ley Federal del Trabajo en materia de subcontratación.
- Panel de BI con reportes SAT / IMSS / INFONAVIT / STPS.
- **Acompañó al equipo del cliente** durante el diseño (mentoring).

### Desarrollo móvil freelance (React Native) — agregado 2026-10

Trabajo paralelo y propio: proyectos pequeños para terceros, en React Native. Se publica como
**una sub-entrada** dentro de la sección única de proyectos independientes ("Selected & Independent
Projects" / "Proyectos Destacados e Independientes"), junto con la plataforma de cumplimiento de
Grupo de la Parra, **sin nombres de proyecto**.

**Proyectos cubiertos (descritos, nunca nombrados):**
- Un marketplace de dos lados (el de "find a friend").
- Un estimador de pensión IMSS bajo la Ley 73 (el de "mi-prensión").
- Un tercer prototipo binario: **excluido** — se descartó por estar incompleto y sin valor
  publicable. No se publica ni se cuenta.

**Stack confirmado:** React Native 0.86 / Expo SDK 57 / TypeScript; Expo Router y React
Navigation; `pdfjs-dist` + `expo-print`; Zod + react-hook-form; AsyncStorage;
Jest / jest-expo / @testing-library/react-native; EAS Update; GitHub Actions.

**Proceso confirmado:**
- **Alan es líder de proyecto** del trabajo móvil: fija la dirección técnica. En el marketplace
  el código lo genera IA bajo la cuenta del cliente; se esperan commits de Alan a partir de
  2026-10, por lo que **no se publica autoría de código línea por línea**.
- Monorepo con **Bun workspaces**, **Turborepo** y **Biome**; **commits convencionales**;
  **GitHub issue tracker** numerado.
- **Contrato de entrega: 12 ADRs, 20 specs y 12 runbooks.** Cada slice de trabajo vive en un
  **git worktree** con su propia base de datos.
- **6 workflows de GitHub Actions** con jobs de prueba fragmentados, **puerta de promoción**
  entre staging y producción, **despliegue a producción con aprobación** y **canales de EAS
  Update**. Las pruebas corren sobre tres runners.
- El estimador IMSS es un **pipeline de 8 pasos de funciones puras**, cada paso con su propia
  base legal, más un **pipeline de PDF totalmente local** (`pdfjs-dist` + `expo-print`) que
  extrae semanas e historial salarial de las constancias y promedia el salario base sobre las
  últimas **250 semanas cotizadas**. Todo se procesa **en el dispositivo** (AsyncStorage, sin
  backend y sin login).
- Cobertura de pruebas: **124 pruebas unitarias y de componente** con **85.9 % de sentencias** y
  **95.2 % de funciones** (perfil Full Stack).

**Lo que NO se puede afirmar del trabajo móvil:**
- **No está publicado en App Store ni Play Store.** No se menciona tienda, descarga, rating
  ni número de usuarios.
- **No hay usuarios, ingresos ni monetización.** No se publica revenue, usuarios activos ni
  pagos en producción.
- El **flujo de pagos no está en producción**: no se afirma que la app procese pagos.
- El camino **nativo** de extracción de PDF es un *fallback heurístico*: la ruta soportada es el
  pipeline local con `pdfjs-dist`. No se promete extracción nativa ni cobertura de todos los
  formatos de constancia.
- No se nombran los proyectos, ni el cliente del marketplace.

**Redacción por perfil** (mismo hecho, ángulo distinto; ver §5):
- **DevOps** — entrega y despliegue: GitHub Actions, puertas de release, EAS Update.
- **Lead** — liderazgo: dirección técnica, monorepo, contrato de entrega, puertas de release.
- **Full Stack** — implementación: navegación, theming, pipeline del estimador, validación y pruebas.
- **AI Engineer** — entrega agéntica: contrato de entrega ejecutable (ADRs, specs, runbooks,
  worktree por slice) y puertas de release. Sin afirmar autoría de código.

### Agentes de IA para desarrollo de software (stack de skills y plugins)

**Confirmado por Alan el 2026-10-21.** El desarrollo de software se hace **con agentes de IA**
(Claude Code) y un stack de skills y plugins que gobierna el proceso. Esto **no** es una
afirmación de ML: son **reglas y skills que un agente ejecuta**, más un servidor MCP local que
indexa el repositorio. La frontera de §4 sigue vigente: nada de esto es entrenamiento de
modelos, fine-tuning, RAG, embeddings, bases vectoriales, MLOps ni llamadas a APIs de LLM.

> **Dónde se usa este stack: solo en la entrega móvil.** Es el stack con el que Alan construye
> y mantiene sus aplicaciones de React Native (el monorepo con un worktree por slice). En
> Veradat se publica **otra cosa**: skills propias, escritas para las tareas de la organización
> y especializadas en automatizar procesos DevOps (el plugin de §3). Los dos conjuntos no se
> mezclan ni se atribuyen el uno al otro.

| Herramienta | Qué es | Qué aporta al proceso |
|---|---|---|
| **Superpowers** | Metodología de desarrollo para agentes de código, construida sobre skills composables | De la idea a la spec, de la spec al plan, del plan a TDD (rojo/verde), implementación por subagentes, revisión y verificación; un worktree por slice |
| **Matt Pocock Skills** | Skills de ingeniería componibles: `to-spec`, `to-tickets`, `implement-spec`, `tdd`, `grilling`, `codebase-design`, `domain-modeling`, `code-review`, `diagnosing-bugs`, `prototype`, `research`, `writing-for-agents` | Enunciar el trabajo antes de codificar: spec y tickets primero, y revisión con criterios explícitos |
| **Ponytail** | Disciplina de solución mínima (YAGNI, biblioteca estándar antes que código propio, plataforma nativa antes que dependencias), con revisión y auditoría de sobre-ingeniería y registro de la deuda deliberada | Que el cambio sea el más pequeño que resuelve el problema, y que lo que se aplaza quede anotado en vez de pudrirse |
| **Karpathy Skills** (`karpathy-guidelines`) | Principios de codificación: supuestos explícitos, simplicidad, cambios quirúrgicos, resultados verificables | Que cada diff sea revisable y que cada resultado se pueda comprobar |
| **Codebase Memory MCP** | Servidor MCP local que indexa el repositorio en un grafo de conocimiento persistente (símbolos, quién llama a qué y qué llama a qué) | Que el agente resuelva la estructura del código y su impacto con una fracción del contexto que cuesta recorrer el árbol entero |

- El servidor MCP **no lleva un modelo dentro**: es análisis estructural local (el
  razonamiento lo hace el agente anfitrión). No es una base vectorial ni un almacén de
  embeddings.
- El stack se usa **en la entrega móvil**, que es el trabajo de código propio de Alan.
- **Las cinco herramientas son de terceros**: se publica que las usa, nunca que las construyó.
  Y nunca se publica como si fueran las skills del plugin de la plataforma.

### Educación y certificaciones
- IPN – ESCOM, B.Sc. Computer Systems Engineering, 2014–2018.
- Java SE – Oracle Certified Associate (2013), con credencial pública.
  **Versión de la certificación confirmada por Alan el 2026-10: Java SE 6.** No se publica el
  número de versión junto al nombre porque al lado de una certificación de 2013 leería como
  desfase. La cifra queda aquí para responder con precisión si un reclutador pregunta.
- Scrum Fundamentals – SCRUMstudy (2018).
- Inglés B2 (upper intermediate). Declarado honestamente en los cuatro perfiles.

---

## 4. Frontera confirmed / NO declarable

Verificado como **no confirmado**. `check-profiles.sh` falla si aparece en cualquier perfil.

| No afirmar | Por qué |
|---|---|
| SLO, error budgets, objetivos de disponibilidad | Solo se confirmó guardia/on-call |
| Postmortems, RCA | No confirmados |
| **Entrenamiento de modelos, fine-tuning, RAG, embeddings, bases vectoriales, MLOps o serving de modelos** | Ese trabajo no existe. Su IA es **aplicada**: skills de Claude Code que enrutan una petición en lenguaje natural a un script determinista (§3). El perfil IA lo declara así, sin insinuar ML |
| **Integración con APIs de LLM, "ingeniería de prompts a escala" o autoría de código generado por IA** | La suite no hace llamadas a modelos: es enrutado a scripts. Y la autoría del código del marketplace está bajo la cuenta del cliente (§3): no se publica como propia |
| **Presentar el grafo de Codebase Memory MCP como base vectorial, embeddings, "búsqueda semántica" o RAG** | Es un grafo de estructura de código que se construye localmente por análisis estático; el MCP no incluye modelo (§3) |
| **Afirmar que construyó Superpowers, Ponytail, las skills de Matt Pocock o las de Karpathy** | Las usa: son proyectos públicos de terceros (§3). Publicar uso, no autoría |
| **Atribuir el stack de terceros (Superpowers, Ponytail, Matt Pocock, Karpathy, Codebase Memory MCP) al trabajo de Veradat, o las skills propias del plugin al trabajo móvil** | Son dos conjuntos distintos: el stack de terceros se usa en la entrega móvil; en Veradat se construyen skills propias para automatizar procesos DevOps (§3). `check-profiles.sh` lo verifica: el stack solo puede aparecer dentro de la sub-entrada móvil |
| Runbooks **en la experiencia laboral** | No confirmados. Los runbooks que sí existen son los 12 del contrato de entrega móvil (§3); `check-profiles.sh` los valida solo dentro de la sub-entrada móvil |
| Guardia 24/7 o en rotación | La guardia fue dentro del horario laboral y sin rotación |
| **"Implementó arquitectura hexagonal"** | La revisó; la implementación fue de otra persona |
| Liderar Scrum, priorizar backlog del equipo, facilitar ceremonias | Era miembro del equipo |
| Dependencias o hitos en Microsoft Project | Solo se confirmó planear por sprint |
| Participación en auditorías o certificaciones ISO 27001 | Su rol fue implementar y operar controles |
| Autoría de políticas/estándares internos | Confirmado en general, sin ejemplo concreto. Redactar como conducta, nunca como entregable |

**Confirmado y publicado:**
- ACM–ICPC (selección de etapa, 2015–2017) y Google Code Jam (2019). Verificados en el CV
  pre-reescritura (`git show 59f3351~1:cv.tex`) y confirmados por Alan; reemplazan a los premios de
  Coding Rush (2014) y Olimpiada Mexicana (2013), que se retiraron de los cuatro perfiles.
  Desde la revisión 2026-10 se publican bajo el rótulo **"Competitive Programming" /
  "Programación competitiva"**, no "Awards": son credenciales de concurso de programación, y
  llamarlas premios corporativos las subestimaba. El nombre de la categoría está en la lista de
  filas de prosa de `check-profiles.sh` (junto a Certification/Languages), que se salta del
  orphan-skill check por no ser skills.
- Los dominios de los controles ISO 27001 son gestión de secretos, control de acceso en nube y
  escaneo de dependencias (confirmado por Alan).

**Pendiente de confirmación** (no publicados):
- *"Stratified Docker image strategy"* (separar librerías comunes del código de cada microservicio)
  se eliminó de los perfiles: describía un patrón de build de Banamex que no corresponde a lo
  que realmente se hizo. Lo que hay en Veradat es la matriz de imágenes por combinación tecnológica.
- Gestión de stakeholders: **confirmada y publicada** en los ocho archivos de contenido a partir
  de la revisión 2026-10. Ver sección 3.

---

## 4b. Texto publicable en LinkedIn

[linkedin/perfil.md](linkedin/perfil.md) contiene **25 bloques
```text** destinados a publicarse. `scripts/check-profiles.sh` los escanea con las mismas
guardarraíles que los perfiles, salvo el chequeo de skills huérfanas (no aplica: no hay filas de
skills).

El bloque móvil va delimitado por los marcadores `<!-- mobile-begin -->` / `<!-- mobile-end -->`,
que quedan **fuera** de las vallas ```text: son los que acotan la mención de los 12 runbooks y
no deben acabar en el texto que se pega en LinkedIn. El bloque de IA (plugin de Claude Code) es
una viñeta más de la experiencia de Veradat, con el mismo alcance que en los perfiles.

Para editarlo: el copy se mide con `humanize.py` y `detect.py` (bloque a bloque, nunca sobre un
`.tex`) y el procedimiento completo está en [AGENTS.md](AGENTS.md) §8. La calificación de los
cuatro perfiles está en [RECRUITER_REVIEW.md](RECRUITER_REVIEW.md).

---

## 4c. Generalizar identificadores internos (no publicarlos)

Un CV se lee desde fuera de la organización. Los nombres propios de tableros, wikis, canales,
convenios o convenciones de etiquetado **no significan nada** para quien contrata yactive una
alarma: o el reclutador lo pasa por alto, o —peor— lo lee como "copió texto interno de la
empresa anterior". Se describe **la función**, no el artefacto.

**Regla:** si el detalle solo sirve para que alguien de dentro lo ubique, se generaliza. Si
describe capacidad, herramienta de mercado o dominio, se conserva.

| Hecho interno (registrado en §3) | Cómo se publica |
|---|---|
| board 'Cambios de Ambiente - DevOps' (pases de QA) | "dashboards y boards de Azure DevOps" (la función, no el tablero) |
| board 'Tortugas Furiosas' (sprint/iteración) | "Microsoft Project por sprint" — el control de sprint es un hecho de §3 |
| tags de release `*-qa` / `*-prod` sobre builds de QA | *ya no se publica*: era detalle de convención interna |
| wiki 'Versiones de imágenes base' | "una wiki compartida como canal asincrónico" |
| formato del reporte de vulnerabilidades al área de seguridad del cliente (tabla de hallazgo, plan de remediación, firma) | "el reporte formal de seguridad que recibe su área de seguridad" — la capacidad, no el artefacto |

> **Por qué se quitó el detalle del reporte y el de release tagging.** En la revisión 2026-10
> la viñeta de coordinación con stakeholders se recortó a lo que un reclutador externo puede
> interpretar. La redacción larga anterior ("notificaciones formales de vulnerabilidades con
> tabla de hallazgo, plan de remediación y firma — Snyk, área de seguridad del cliente")
> describía el formato de un documento interno: o se pasa por alto, o se lee como texto
> copiado del manual de operaciones del cliente. `scripts/check-profiles.sh` sigue exigiendo
> la cadena "dashboards and boards" / "dashboards y boards" en los ocho perfiles.

**Lo que NO se generaliza** (sí aporta a quien contrata):

- Herramientas de mercado yversión: Azure DevOps, Terraform, Kubernetes, Snyk, Splunk, ServiceNow.
- Regulatory bodies del dominio: SAT, IMSS, INFONAVIT, STPS, CFDI. Dan profundidad de sector.
- Métricas: 70 microservicios, 21 clústeres de preproducción, 6 h → 1 h, 1,000 transacciones/día,
  5,000 empleados.
- Empleadores y clientelas: Veradat, IDS Comercial, GLOBAL HITSS, Everis, Banamex, Telcel.
- Integraciones con productos de terceros en el proyecto freelance (p. ej. **Contpaqi**): evidencia
  de trabajo real con sistemas externos.

---

## 5. Matriz de énfasis por perfil

Cada perfil conserva su propio foco sobre los mismos hechos. **No contradecirse.**

| | DevOps | DevOps/SRE Lead | Full Stack | AI Engineer |
|---|---|---|---|---|
| Título | DevOps Engineer · AWS, K8s, CI/CD | DevOps/SRE Engineer Lead · Debt Remediation | Senior Full Stack Software Engineer | AI Engineer · Claude Code & Agent Skills |
| Abre con | Provisioning AWS/Terraform, velocidad de despliegue | Deuda técnica, ISO 27001, liderazgo, gobernanza | Ownership de entrega, arquitectura de microservicios | Tooling agéntico: plugin de Claude Code, 4 skills, enrutado intención→script |
| Hexagonal + imágenes | Una línea (ángulo infra) | Protagonista (revisión + gobernanza) | Una línea (ángulo arquitectura) | Una línea (revisada) |
| ISO 27001 | Una línea | Protagonista, ambas empresas | Una línea | Una línea |
| Mentoring / guardia | Se omite | Protagonista | Se omite | Se omite |
| POM padre Maven | Promovido (deuda técnica) | Promovido (estándar) | Se mantiene | Se mantiene |
| Proyecto freelance (cumplimiento) | 3 bullets, comprimido | 3 bullets, elevado (compliance) | 5 bullets, completo | 2 bullets, elevado (compliance + motor de auditoría) |
| Sub-entrada móvil (sin nombres de proyecto) | 2 bullets — **énfasis en despliegue**: GitHub Actions, puertas de release, EAS Update, producción | 2 bullets — **énfasis en liderazgo**: dirección técnica, monorepo, contrato de entrega, puertas de release | 3 bullets — **éntesis en implementación**: navegación, theming, pipeline del estimador, validación y pruebas | 2 bullets — **énfasis en entrega agéntica**: contrato de entrega (ADRs, specs, runbooks, worktree por slice) y puertas de release |
| Bloque de IA (skills custom de Claude Code) | Una línea (skills propias para automatizar procesos DevOps) | Una línea | Una línea | **Protagonista**: skills propias para las tareas de la organización, 4 skills, 35 scripts Python (~10,800 líneas), ~3,200 líneas de `SKILL.md`, índice autogenerado |
| Agentes de IA para desarrollo (Superpowers, Matt Pocock Skills, Ponytail, Karpathy Guidelines, Codebase Memory MCP) | Solo en la entrega móvil, enfoque en entrega | Solo en la entrega móvil, enfoque en proceso y revisión | Solo en la entrega móvil, enfoque en implementación | Solo en la entrega móvil, **en detalle**: la metodología agéntica completa y el grafo de conocimiento del código |

**Negritas.** La negrita marca lo que un reclutador debe leer primero en cada perfil: la métrica
(los números de §2), el entregable que construyó y el tema del perfil según la matriz de arriba.
Reglas:

- Máximo **~3 negritas por viñeta** (1–2 es lo ideal). Una viñeta sin negrita es válida.
- **Nunca** se pone en negrita una herramienta que ya aparece en la barra lateral: el lector ya
  la tiene a la vista y la negrita sólo añade ruido.
- EN y ES toman **exactamente la misma decisión** en la viñeta correspondiente.
- La negrita no cambia lo que se afirma: si una frase se puede poner en negrita, es porque el
  texto ya dice algo que la sostiene.

---

## 6. Verificación

```bash
make check          # o: bash scripts/check-profiles.sh
```

Comprueba: fechas y empleadores consistentes, métricas iguales entre EN y ES, ausencia de
términos prohibidos, sin herramientas huérfanas en las filas de skills, y cero ocurrencias de
`Citibanamex` (el nombre correcto es **Banamex**).

Además, desde la revisión 2026-10 comprueba también la **sección de proyectos independientes**:
exactamente una sección por perfil, con las dos sub-entradas (móvil y cumplimiento), la sub-entrada
móvil con React Native y Expo fechada **2023 – 2026** (solo años), **sin nombres de proyecto**, y
**sin afirmaciones de publicación en tiendas, usuarios ni ingresos**. Los runbooks solo se aceptan
dentro del contrato de entrega móvil, nunca en la experiencia laboral: el rango se delimita con los
marcadores `% mobile-begin` / `% mobile-end`.

Además, todos los PDFs deben quedar en **2 páginas** — es el criterio de aceptación de layout.
Los ocho perfiles ATS y los ocho diseñados (16 PDF) quedan hoy en 2 páginas.

En la variante con diseño, la barra lateral es una caja que no se parte entre páginas: si su
contenido no cabe, **se pierde en silencio**. Hay que medirla (`pdftotext -bbox` y la
coordenada `yMax` de la última palabra de la barra) después de tocarla. El marco de texto
termina en **766.5 pt** (792 − 25.5 de margen inferior). Hoy las ocho barras caben: la más
ajustada es la del perfil Full Stack ES, en 763 pt.

> `pdftotext -bbox` **no sirve para medir el final de una viñeta**: cada viñeta va envuelta en
> un span `/ActualText` (`styles/actualtext.tex`) y el extractor devuelve una caja por viñeta
> cuya posición no es la de los glifos. Para medir de verdad hay que renderizar la página
> (`pdftoppm -r 72`) y buscar la última fila con tinta dentro de la región del marco, en
> blanco y en la barra lateral (x < 195 pt).

Y la columna principal de los ocho perfiles con diseño también cabe: los más ajustados son el
Full Stack ES (756 pt) y el DevOps/SRE Lead ES (749 pt) contra los 766.5 pt del marco.

El procedimiento completo de edición y homologación —qué tocar al cambiar cada dato, el
checklist de cierre y las convenciones de commit— está en [AGENTS.md](AGENTS.md).