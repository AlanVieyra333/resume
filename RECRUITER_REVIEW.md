# RECRUITER_REVIEW — calificación de los cuatro perfiles

Revisión del paquete de CV como la haría **un reclutador senior** que recibe 200 postulaciones y
tiene 30 segundos por archivo. Método: la rúbrica de `li-profile` (12 ítems, 100 puntos),
adaptada a currículum, más una lectura de lo que un filtro automático y una entrevista de
screening pueden objetar de cada perfil.

**Alcance de esta revisión:** los 16 PDFs (4 perfiles × 2 idiomas × 2 variantes) y el copy de
`linkedin/perfil.md`. Hechos y cifras: `FACTS.md`. Procedimiento de edición:
`AGENTS.md`.

---

## 1. Resumen ejecutivo

| Perfil | PDF | Encaje por defecto | Puntuación CV (/100) | Veredicto |
| --- | --- | --- | --- | --- |
| **DevOps Engineer** | `out/Resume_DevOps_AFRV_{EN,ES}.pdf` | DevOps/SRE mid, Cloud, Platform, Infra as Code | **73** | Enviar. Es el CV más sólido del paquete y el que más veces se puede mandar. |
| **DevOps/SRE Engineer Lead** | `out/Resume_DevOpsLead_AFRV_{EN,ES}.pdf` | Lead de plataforma, deuda técnica, estándares y gobierno | **77** | Enviar. El ángulo de remediación de deuda técnica es el más vendible del paquete. |
| **Senior Full Stack** | `out/Resume_FullStack_AFRV_{EN,ES}.pdf` | Full Stack, React/React Native, Java/Spring | **76** | Enviar con cuidado: los últimos dos años se leen como infraestructura, no como producto. |
| **AI Engineer** | `out/Resume_AIEngineer_AFRV_{EN,ES}.pdf` | AI tooling, agentes, Claude Code, plataforma | **79** | Enviar a vacantes de IA aplicada. **No** presentarlo como candidato de ML. |

**Las tres objeciones que se repiten en los cuatro perfiles**, y que conviene responder antes de
la primera entrevista:

1. **"¿Qué producción operaste?"** Los 21 clústeres son **de preproducción** (9 QA, 4 DEV,
   4 INTGR, 4 Certificación). El CV lo dice con esas palabras, sin inflarlo. La producción
   estricta se cubrió en Banamex con Splunk y con la guardia **dentro del horario laboral**.
2. **"¿Tienes experiencia de SRE?"** Hay operación, triaje de incidentes y guardia acotada, pero
   **no** hay SLO, ni error budget, ni postmortem. No está confirmado y no se publica. Un perfil
   de SRE puro (con on-call 24/7 y objetivos de disponibilidad) no es el objetivo.
3. **"¿Qué certificaciones tienes vigentes?"** La de Java SE es de **2013** y la de Scrum
   Fundamentals de **2018**. No hay ninguna vigente en la nube. Es la brecha más fácil de cerrar
   y la que más mueve el filtro de un portal.

---

## 2. Cómo seAdaptó la rúbrica

La rúbrica de `li-profile` está pensada para un perfil de LinkedIn. Se separó en dos partes:

**Parte A — lo que aplica al PDF (78 puntos, reescalado a 100).** Los cinco ítems que solo
existen en LinkedIn seevalúan aparte, en la parte B, porque declararlos en cero castigaría al
CV por algo que no es del CV.

| Ítem `li-profile` | Puntos | Cómo se lee en un CV |
| --- | --- | --- |
| `headline` | 12 | Título del puesto + la primera línea del resumen |
| `about_open` | 10 | Las dos primeras líneas del resumen: ¿nombran el problema de quien lee? |
| `about_body` | 10 | Cuerpo del resumen: qué haces, prueba con un número, y a qué sigue |
| `current_role` | 10 | El bloque de Veradat: una línea de alcance y bullets con resultados |
| `experience_depth` | 8 | Banamex y Telcel, y cómo se comprimen los puestos antiguos |
| `skills` | 6 | Las filas de la barra lateral: ¿las tres primeras son las que quieres que te contraten? |
| `featured` → *proyectos independientes* | 8 | En el CV, la prueba pública es la sección de proyectos independientes |
| `contact` | 6 | Correo, LinkedIn, GitHub, ubicación y zona horaria |

**Parte B — lo que solo aplica al perfil de LinkedIn (38 puntos).** Se mide el estado del
perfil publicado, no el del CV: `featured` (8), `banner` (6), `photo` (6),
`recommendations` (8) y `activity` (10).

---

## 3. DevOps Engineer — `out/Resume_DevOps_AFRV_{EN,ES}.pdf`

| Ítem | Puntos | Nota |
| --- | --- | --- |
| headline | 7/12 | El encabezado es solo el título; la prueba vive en el resumen, una línea más abajo. |
| about_open | 8/10 | Abre con "DevOps engineer with a software development background since 2017": es contexto, no el problema de quien lee. |
| about_body | 10 | Ofrece (aprovisionar, operar, automatizar) con prueba. Sin cierre de "qué sigue". |
| current_role | 9/10 | Veradat: 20 pipelines, 70 microservicios, 6 h → 1 h, 21 clústeres, 60 → 30 min, 2 h → 20 min, 30 procesos automatizados con shell scripting. |
| experience_depth | 8/8 | Banamex y Telcel con detalle; Nova Solutions y CINVESTAV fuera. |
| skills | 5/6 | Las tres primeras (AWS, Terraform, Kubernetes) son las correctas; el resto diluye. |
| proyectos | 6/8 | Los 12 runbooks y las puertas de release son prueba real, sin resultado publicado. |
| contact | 6/6 | Correo, LinkedIn, GitHub, teléfono, ciudad y zona horaria. |
| **Total** | **57/78 → 73/100** | |

### Fortalezas

- **Terraform con nombres propios, no genéricos.** EC2, S3, VPC, Security Groups, IAM, RDS,
  CloudWatch y Route 53, en AWS y Azure, más Ansible para 10 servidores: es el bloque que más
  filtra un recruiter técnico, porque demuestra que el código se ejecutó, no que se leyó.
- **Una sola cifra sostiene el bloque de entrega:** 70 microservicios, 6 horas → 1 hora. Es
  concreta, es verificable y es de las pocas que un candidato cualquiera no puede escribir.
- **ISO 27001 como rol de implementación y operación**, en dos entornos regulados. No es
  "participé en la auditoría", que es la versión que el CV anterior insinuaría.
- **21 clústeres de preproducción** con el desglose real (9 QA, 4 DEV, 4 INTGR, 4 Certificación)
  y Elastic Stack solo donde aplica (los 9 de QA). La precisión del desglose es la prueba de que
  el dato no es de adorno.

### Debilidades

- **Sin señal de escala de producción.** Ni usuarios, ni transacciones de la plataforma, ni
  volumen de logs, ni coste gestionado. Un DevOps senior que haya ledeado un clúster de
  producción grande va a preguntar por el volumen, y el CV no lo responde.
- **Sin números de coste.** No hay "ahorré X %" en infraestructura. Es la pregunta que
  distingue a un DevOps de un administrador de servidores.
- **On-call declarado dentro del horario.** Es honesto y hay que decirlo, pero reduce el
  encaje en vacantes de SRE con guardia real.
- **La experiencia móvil es reciente pero sin usuarios publicados**, y en este perfil ocupa poco
  espacio: correcto, no debe ocupar más.

### Objeciones de screening y respuesta preparada

| Objeción | Respuesta |
| --- | --- |
| "¿Operaste producción?" | "Operé 21 clústeres **de preproducción** — QA, DEV, Integración y Certificación — con monitoreo y alertas. La producción estricta la operé en Banamex con Splunk y tickets en ServiceNow bajo SLA de 1 día." |
| "¿Tienes SLOs y error budgets?" | "No. Mi rol fue operación y confiabilidad: guardia dentro del horario, triaje de incidentes, tiempos de detección de 60 a 30 minutos. La gestión de objetivos de disponibilidad formal no la he tenido." |
| "¿Qué volumen manejas?" | "70 microservicios en 3 equipos con un solo pipeline de despliegue por release; 21 clústeres y 10 servidores aprovisionados con Ansible." |
| "¿Kubernetes o OpenShift?" | "Los dos: Kubernetes en QA y Certificación, OpenShift en DEV e Integración. En Telcel migré de Tomcat a OpenShift." |
| "¿Qué certificaciones tienes?" | "Java SE de Oracle (2013) y Scrum Fundamentals (2018). Cloud lo aprendí en el trabajo." |

---

## 4. DevOps/SRE Engineer Lead — `out/Resume_DevOpsLead_AFRV_{EN,ES}.pdf`

| Ítem | Puntos | Nota |
| --- | --- | --- |
| headline | 8/12 | El título declara el ángulo (deuda técnica) y es preciso. |
| about_open | 9/10 | Abre con "Has led technical debt remediation across 20 CI/CD pipelines serving three teams": nombra el problema. |
| about_body | 8/10 | Buen cuerpo; le falta el "a qué sigue". |
| current_role | 9/10 | Hexagonal + matriz de imágenes como protagonistas, ISO 27001, mentoría de 10 ingenieros. |
| experience_depth | 8/8 | Los tres empleadores, con el bloque de standards en su lugar. |
| skills | 5/6 | Fila de gobierno (ISO 27001, hexagonal, Scrum, Project) bien colocada. |
| proyectos | 7/8 | El bullet móvil (dirección técnica, monorepo, contrato de entrega) es leadership de verdad. |
| contact | 6/6 | Completo. |
| **Total** | **60/78 → 77/100** | |

### Fortalezas

- **Es el único perfil donde elLeadership es demostrable con un entregable:** revisar la
  arquitectura hexagonal del equipo, producir la imagen Docker por cada combinación
  tecnológica y convertir los charts de Helm en el estándar de despliegue de los tres equipos.
  Eso es estandarización con nombre y apellido, no "promoví buenas prácticas".
- **Mentoría de 10 ingenieros** con revisiones de código y de diseño, decisiones técnicas y
  onboarding, más planificación por sprint en Microsoft Project: hay una línea de gobierno
  técnica, no solo ejecución.
- **ISO 27001 implementado y operado en dos empleadores**, que es exactamente el tipo de cosa
  que se pide en un rol de gobierno técnico en banca.
- **Declara la guardia dentro del horario**, y por tanto no promete un modelo de guardia que no
  puede sostener. La honestidad aquí juega a favor en la segunda entrevista.

### Debilidades

- **El título dice Lead y el cargo de Veradat es DevOps Engineer.** Es un riesgo real de
  screening: alguien puede leerlo como que seTITLEinfló. La mitigación está en el cuerpo (10
  ingenieros,standards, revisión de arquitectura), pero conviene tener lista la explicación de
  que el liderazgo es técnico y no de reporte.
- **No hay ownership de presupuesto, roadmap ni headcount.** "10 ingenieros mentoreados" no es
  "10 personas a cargo", y no debe Becoming confuso en una entrevista.
- **La deuda técnica se cuenta, no se mide.** No hay un antes/después: ni tiempo de
  mantenimiento, ni tasa de cambio fallido, ni lead time. Es la métrica que le falta al ángulo
  más vendible del paquete.
- **Sin SRE formal**, igual que en el resto de perfiles: hay guardia acotada y operación, no
  objetivos de disponibilidad.

### Objeciones de screening y respuesta preparada

| Objeción | Respuesta |
| --- | --- |
| "¿Eres manager de personas?" | "No: soy líder técnico. Reviso código y diseño, tomo decisiones de arquitectura, acompaño el onboarding y defino los estándares de despliegue. Lo que hago con las personas es revisión y mentoría, no evaluación de desempeño." |
| "¿A cuántos reportas?" | "Ninguno formalmente. Acompaño a 10 ingenieros de los equipos de frontend, backend y QA." |
| "¿Cómo mediste la deuda técnica?" | "No la medí con un indicador único; lo que hice fue atacarla de frente: estandarizar el despliegue con Helm, la imagen Docker por combinación tecnológica y el POM padre de Maven. Medirla con números es justo lo que me falta." |
| "¿Lideras Scrum?" | "No. Soy miembro del equipo, no scrum master." |
| "¿El título de Lead es oficial?" | "En Veradat mi cargo es DevOps Engineer. El liderazgo es de facto sobre los estándares de despliegue y la arquitectura; el título de esta versión del CV describe el alcance real del trabajo, no una posición de reporte." |

---

## 5. Senior Full Stack Software Engineer — `out/Resume_FullStack_AFRV_{EN,ES}.pdf`

| Ítem | Puntos | Nota |
| --- | --- | --- |
| headline | 9/12 | "Senior Full Stack Software Engineer" con ownership extremo a extremo en el resumen. |
| about_open | 8/10 | Enumera stacks; no formula el problema del lector. |
| about_body | 8/10 | Buen cuerpo, con la plataforma de cumplimiento como prueba grande. |
| current_role | 7/10 | **El bloque de Veradat es de infraestructura.** En una postulación de Full Stack, los dos años más recientes se leen como DevOps. |
| experience_depth | 8/8 | Banamex, Telcel, el trabajo móvil y la plataforma de cumplimiento. |
| skills | 5/6 | Filas separadas de frontend, backend y móvil: bien. |
| proyectos | 8/8 | La mejor prueba de producto del paquete: 124 pruebas, 85.9 % de sentencias, 95.2 % de funciones, pipeline local de PDF, integración con Contpaqi. |
| contact | 6/6 | Completo. |
| **Total** | **59/78 → 76/100** | |

### Fortalezas

- **Tiene producto en el CV, no solo infraestructura.** El pipeline de PDF local (`pdfjs-dist` +
  `expo-print`) que extrae semanas cotizadas y promedia el salario base sobre 250 semanas, con
  **Zod + react-hook-form** validando cada entrada y todo el procesamiento **en el dispositivo**,
  sin backend ni login: es la prueba más concreta de criterio de ingeniería de producto del
  paquete. Y tiene cobertura: 124 pruebas al 85.9 % / 95.2 %.
- **El POM padre multimódulo de Maven** con gestión compartida de dependencias, que se
  posiciona como deuda técnica resuelta y es una conversación de arquitectura que casi nadie
  puede dar.
- **La plataforma de cumplimiento es un proyecto completo**: 5,000 empleados cubiertos, motor de
  auditoría de reglas regulatorias, panel de BI con SAT/IMSS/INFONAVIT/STPS, integración con
  Contpaqi, y un diseño de 5 bullets. Es el proyecto por el que un reclutador de Full Stack
  entiende su nivel de seniority.
- **Angular y Java/Spring en producción** además de React: breadth con prueba, no con listas.

### Debilidades

- **La recencia no es de frontend.** Entre 2024 y 2026 el trabajo publicado es CI/CD, clústeres,
  Terraform e ISO 27001. Para una vacante de Full Stack senior, el screening automático mira
  las fechas de React y encuentra el trabajo móvil de 2023-2026, no 2025-2026.
- **El trabajo móvil no tiene usuarios publicados.** No está en tienda, no hay descargas, no
  hay ingresos. Es correcto no publicarlo, pero significa que **la prueba de producto es
  técnica, no de adoption**.
- **No hay liderazgo de producto ni de diseño.** Nada de mentoría en frontend, ni ownership de
  la hoja de ruta de un producto, ni decisiones de UX.
- **La amplitud del stack**: React, React Native, Angular, TypeScript, Java, Spring, Node.
  Es breadth con prueba, no breadth de lista: un recruiting manager puede leer "mucho" en
  lugar de "profundo".

### Objeciones de screening y respuesta preparada

| Objeción | Respuesta |
| --- | --- |
| "¿Tus últimos dos años fueron de backend o de infra?" | "En Veradat mi rol fue DevOps: pipelines, clústeres, Terraform. El desarrollo de producto de los últimos años es el trabajo móvil en React Native y Expo y la plataforma de cumplimiento." |
| "¿La app tiene usuarios?" | "Es trabajo freelance para clientes; no está publicada en tiendas y no tiene usuarios públicos. Lo que sí se puede ver es el diseño técnico: pipeline local de PDF, validación con Zod, 124 pruebas." |
| "¿Cuánta experiencia con React?" | "React desde el proyecto bancario (2021-2024) y React Native desde 2023, con Expo Router y Expo SDK." |
| "¿Backend o frontend?" | "Full stack de verdad: 10 microservicios Java/Spring Cloud en banca, React/Node/TypeScript en frontend, PostgreSQL y Oracle." |
| "¿Dónde está tu contribution en el código de las apps?" | "En el marketplace el código lo genera IA bajo la cuenta del cliente; mi responsabilidad fue la dirección técnica y el contrato de entrega. En el estimador del IMSS la implementación es mía." |

---

## 6. AI Engineer — `out/Resume_AIEngineer_AFRV_{EN,ES}.pdf`

| Ítem | Puntos | Nota |
| --- | --- | --- |
| headline | 10/12 | "AI Engineer \| Claude Code, Agent Skills & Agentic Development": dice el rol y el método, y el resumen abre con el plugin y sus cifras. |
| about_open | 9/10 | Abre declarando el alcance ("applied AI and agentic tooling") y luego la prueba. |
| about_body | 8/10 | El resumen cierra con "antes, 20 pipelines y 21 clústeres": no es un perfil de IA puro, y eso es una decisión, no un descuido. |
| current_role | 9/10 | El plugin es el protagonista, y la base de infraestructura (20 pipelines, 21 clústeres, 30 procesos automatizados con shell scripting, Terraform, ISO 27001) sostiene que las skills corrieron contra la plataforma real. |
| experience_depth | 8/8 | Los tres empleadores, el bloque móvil en clave de entrega agéntica y la plataforma de cumplimiento. |
| skills | 6/6 | La primera fila es exactamente "AI & Agentic Tooling: Claude Code, SKILL.md, Python, Bash, YAML, JSON". Es el único perfil cuya lista de skills empieza por lo que quiere que le contraten. |
| proyectos | 6/8 | El plugin es privado: no hay repositorio público, ni enlace, ni captura. La prueba existe pero no se puede verificar desde fuera. |
| contact | 6/6 | Completo. |
| **Total** | **62/78 → 79/100** | |

### Fortalezas

- **El número de skills, de scripts y de líneas es verificable y concreto:** 4 skills, 35 scripts
  deterministas en Python (~10.800 líneas), ~3.200 líneas de `SKILL.md`, y un script que genera
  automáticamente el índice de capacidades. No hay adjetivos: hay un inventario.
- **La unidad de trabajo está explicada.** "La intención entra en lenguaje natural, sale un
  script determinista": es una arquitectura, no un prompt. En una entrevista esa frase se
  defiende sola.
- **Las skills corren contra la plataforma real**, no contra un entorno de demostración:
  validación de releases y work items, verificación de builds contra su rama, redespliegue de un
  nodo en las versiones que ya corre, auditoría de configuración contra el manual de la
  plataforma, lectura de secretos en AWS Secrets Manager y reportes de Snyk. Todo eso es
  operación de plataforma, no demostración.
- **El CV declara su propia frontera.** Dice "IA aplicada y agéntica" y "no entrena modelos".
  Un reclutador de IA que filtra por ML ve la frontera declarada y no se siente engañado; un
  reclutador que quiere un ingeniero de tooling ve un perfil con criterio.
- **El stack de desarrollo agéntico está nombrado, no insinuado.** Superpowers, Matt Pocock
  Skills, Ponytail, Karpathy Guidelines y Codebase Memory MCP aparecen en la entrega móvil, con
  el proceso que gobiernan: spec, plan, TDD, subagentes y revisión. Es la diferencia entre
  "usa IA" y "tiene un proceso de ingeniería para usarla": es exactamente lo que se le pregunta
  a un ingeniero de IA en la primera media hora.
- **Las skills de la plataforma son propias y ya son un producto.** "Skills custom de Claude
  Code para las tareas de la organización, especializadas en automatizar procesos DevOps" es
  una frase que se sostiene sola en una entrevista: no es un wrapper de prompts, es un
  inventario de 4 skills, 35 scripts y ~3.200 líneas de `SKILL.md` con un índice autogenerado.

### Debilidades

- **No hay ML, y no lo va a haber.** Sin entrenamiento, sin RAG, sin embeddings, sin vector
  store, sin MLOps, sin llamada a API de LLM. La vacante típica de "AI Engineer" en 2026 busca
  exactamente eso. Este perfil **no compite** en esa vacante, y decirlo es más honesto que
  intentarlo.
- **La prueba es privada.** El plugin está en un repositorio privado del trabajo: sin repo
  público, sin vídeo, sin captura, el reclutador no puede verificar 35 scripts. Es la brecha
  número uno del perfil.
- **No hay métrica de resultado.** 35 scripts y 3.200 líneas son de entrada, no de impacto. No
  hay "ahorré X horas de operación" ni "se resolvíeron Y tickets sin intervención".
- **La rama de IA tiene menos de un año visible** (Veradat desde agosto de 2024) y las skills se
  publicaron al final. No hay historial que un recruiter pueda fechar.
- **El resto del perfil es DevOps.** Kubernetes, OpenShift, Terraform, ISO 27001: es la base
  correcta para un "AI engineer de plataforma", pero en una vacante de IA de producto se lee
  como un perfil de infraestructura con un bloque de IA.

### Objeciones de screening y respuesta preparada

| Objeción | Respuesta |
| --- | --- |
| "¿Esto es prompt engineering o ingeniería?" | "Ingeniería. La intención en lenguaje natural se mapea a un script determinista mediante el frontmatter del SKILL.md. El script decide; el modelo no. No hay llamada a una API de LLM en el loop." |
| "¿Has entrenado modelos?" | "No, y no es lo que hago. Mi trabajo es el tooling alrededor: cómo un agente ejecuta una operación real de plataforma de forma reproducible y auditable." |
| "¿Lo has usado en producción?" | "Sí, contra la plataforma real: releases, work items, builds, redespliegues de nodo, auditoría de configuración, secretos de AWS y reportes de Snyk." |
| "¿Por qué 4 skills y no un agente genérico?" | "Una skill por dominio operativo (Azure DevOps, AWS, Kubernetes/OpenShift, Snyk). Un agente único con 18 capacidades es más difícil de revisar y de auditar; cuatro skills con un contrato de invocación explícito es más legible y más seguro." |
| "¿Puedes mostrar el código?" | "El código es del empleador y no es público. Puedo describir la estructura, el contrato de invocación y el índice de capacidades generado." |

### Qué haría subir este perfil (y requiere información o trabajo nuevo)

1. **Repositorio público con los scripts** (o una demostración grabada). Es el movimiento de
   mayor rendimiento: convertiría 35 scripts en prueba verificable.
2. **Una métrica de resultado del toolkit**: tiempo de operador ahorrado por semana, tickets
   resueltos sin intervención, o tiempo de redacción de reportes de vulnerabilidad.
3. **Un artículo técnico** sobre el patrón "intención → script determinista" con el
   `SKILL.md` de ejemplo, sin datos del empleador. Es la pieza de Destacado que le falta.
4. **Una certificación vigente** en la nube: es la señal que un filtro automático exige y hoy
   no existe en el paquete.

---

## 7. Transversal: a qué vacante se manda qué

| Tipo de vacante | PDF a enviar | Encaje |
| --- | --- | --- |
| DevOps mid/senior, SRE operativo, Cloud, Platform, Terraform | `Resume_DevOps_AFRV_{ES,EN}.pdf` | Muy alto. Es el perfil más completo y el que cubre más vacantes. |
| Lead de plataforma, deuda técnica, estándares, ISO 27001, gobierno técnico | `Resume_DevOpsLead_AFRV_{ES,EN}.pdf` | Muy alto. El ángulo es vendible y el bloque de estándares lo sostiene. |
| Full Stack (Java/Spring + React), React Native, fintech | `Resume_FullStack_AFRV_{ES,EN}.pdf` | Alto con la salvedad de la recencia de infra en los últimos dos años. |
| AI tooling, agentes, Claude Code, IA en plataforma, developer experience | `Resume_AIEngineer_AFRV_{ES,EN}.pdf` | Alto **para IA aplicada**. No para ML ni para IA de producto. |
| ML Engineer, MLOps, LLM fine-tuning, RAG | — | **Fuera de alcance.** No es honesto presentarse, y el perfil AI lo declara. |

Reglas de envío:

- **Variante ATS** (`make ats`, sufijo `_ATS`) para portales y ATS: una columna, texto
  seleccionable, sin gráficos que rompan el parser.
- **Variante con diseño** (`make design`, sin sufijo) para una persona: banda con foto, barra
  lateral y línea de tiempo. Es el CV principal y el que se manda por correo o mensaje.
- **Idioma**: `_ES` para vacantes en México y Latinoamérica, `_EN` para el resto y para vacantes
  en inglés. Los dos idiomas son equivalentes en cifras y fechas: no hay ventaja de uno sobre
  otro.
- Los **16 PDFs deben estar en 2 páginas**: si al añadir algo se rompe, sobra texto, nunca se
  recorta una métrica.

---

## 8. Estado del perfil de LinkedIn (parte B: 38 puntos)

| Ítem | Puntos | Estado |
| --- | --- | --- |
| featured | 2/8 | La tabla de Destacado tiene 5 piezas definidas, pero 4 están "por preparar" y una depende de un repositorio público que no existe. |
| banner | 3/6 | El texto del banner está listo (dos variantes: DevOps e IA); la imagen no está producida. |
| photo | 4/6 | La foto existe y se usa en la variante con diseño del CV; falta confirmar que sea reciente y que el encuadre deje espacio para el banner. |
| recommendations | 0/8 | No hay ninguna recomendación publicada. Es el punto más barato y más rentable de la lista. |
| activity | 0/10 | Sin publicaciones. Un perfil sin actividad reciente se lee como abandonado. |
| **Total** | **9/38** | |

Esta parte **no la arregla un texto**: necesita recomendaciones de colegas y clientes, un
banner producido y un pie de foto de perfil actualizado. Lo que sí hizo esta revisión fue dejar
los bloques de copy listos (`linkedin/perfil.md`, 25 bloques), con el titular de
IA incluido y los cuatro titulares medidos por debajo de 220 caracteres.

---

## 9. Correcciones aplicadas en esta revisión

Cambios de texto hechos sobre la base de la evaluación, no solo señalados:

| # | Corrección | Dónde |
| --- | --- | --- |
| 1 | **Una sola sección de proyectos independientes**, con dos sub-entradas tituladas por el tipo de proyecto (móvil y plataforma de cumplimiento) en lugar de dos secciones separadas. | Los 8 archivos de `lang/` |
| 2 | **Nuevo perfil de AI Engineer** (EN/ES), sin nada inventado: el plugin de Claude Code con sus cifras reales y una declaración explícita de que la IA es aplicada, no ML. | `lang/ai/en.tex`, `lang/ai/es.tex` |
| 3 | El bloque móvil del perfil IA cambió de "construcción de apps" a **entrega agéntica** (contrato de entrega ejecutable), sin afirmar autoría del código del marketplace. | `lang/ai/{en,es}.tex` |
| 4 | "Administro 9 clústeres: 8 Kubernetes y 1 OpenShift" → **21 clústeres de preproducción** con el desglose real (9 QA, 4 DEV, 4 INTGR, 4 Certificación). | `linkedin/perfil.md` |
| 5 | "9 clústeres de producción" → **21 de preproducción**; "en los 9 clústeres" → **en los 9 de QA** (Elastic Stack solo corre en QA). | `linkedin/perfil.md` |
| 6 | Banamex: "pipelines con Azure DevOps y Jenkins" → **solo Jenkins** (Azure DevOps es la plataforma de Veradat). | `linkedin/perfil.md` |
| 7 | Viñeta de **Claude Code** añadida a la experiencia de Veradat (ES y EN) con el alcance real. | `linkedin/perfil.md` |
| 8 | **Sub-entrada móvil** añadida al copy de LinkedIn, delimitada por `<!-- mobile-begin -->` / `<!-- mobile-end -->`. | `linkedin/perfil.md` |
| 9 | Titular de **AI Engineer** como cuarta opción del perfil de LinkedIn. | `linkedin/perfil.md` |
| 10 | **Acerca de** reescrito con ritmo de frase variado (variación de longitud 0.32 → 0.63 en español y 0.33 → 0.56 en inglés) y **recortado a 1,340 / 1,320 caracteres**, por debajo del objetivo editorial de 1,400. | `linkedin/perfil.md` |
| 11 | PDF del perfil IA añadido a la tabla de Destacado, junto con el plugin como pieza de prueba. | `linkedin/perfil.md` |
| 12 | Tríada "React, TypeScript, and Node.js" corregida a "React, TypeScript and Node.js" en el perfil Full Stack EN. | `lang/fullstack/en.tex` |
| 13 | Puesto en inglés dentro del archivo en español: "DevOps Engineer" → **"Ingeniero DevOps"**. | `lang/lead/es.tex` |
| 14 | `check-profiles.sh` ampliado: sección única de proyectos independientes, fechas `2023 -- 2026`, marcadores móviles, **prohibición de contenido de ML**, cifras del plugin obligatorias en el perfil IA y prohibición del conteo de capacidades. | `scripts/check-profiles.sh` |
| 15 | `AGENTS.md` creado: manual de homologación, matriz de qué tocar al cambiar cada dato, checklist de cierre y convenciones de commit. | `AGENTS.md` |
| 16 | **Stack de desarrollo agéntico añadido** (Superpowers, Matt Pocock Skills, Ponytail, Karpathy Guidelines, Codebase Memory MCP), **solo dentro de la entrega móvil** en los ocho perfiles, y el bloque móvil del copy de LinkedIn. En Veradat, en cambio, la viñeta pasó de "asistente de desarrollo" a **"skills custom de Claude Code para las tareas de la organización, especializadas en automatizar procesos DevOps"**. Se publica como **usado**, nunca como construido; el grafo de Codebase Memory MCP se describe como índice de estructura del código, no como base vectorial; y `check-profiles.sh` verifica que el stack no salga de los marcadores de la sub-entrada móvil. | `FACTS.md` §3, §4 y §5, los 8 archivos de `lang/`, `linkedin/perfil.md`, `scripts/check-profiles.sh` |

---

## 10. Lo que no se puede arreglar sin información o trabajo nuevo

Nada de esto se inventó, y nada se aplicó al CV:

1. **Una certificación vigente** (AWS Solutions Architect, CKA, Terraform Associate). La de Java SE
   es de 2013 y la de Scrum de 2018. Es la brecha que más veces va a filtrar una postulación.
2. **Repositorio público con los scripts del plugin de Claude Code**, o una demostración
   grabada. Convierte la prueba más fuerte del perfil IA en algo verificable.
3. **Métricas de impacto del toolkit de skills**: horas de operador ahorradas, tickets
   resueltos sin intervención, tiempo de redacción de reportes de vulnerabilidad. Sin esto, el
   perfil IA publica inventario, no resultado.
4. **Métricas de escala de plataforma**: volumen de requests, de logs, coste gestionado o
   usuarios. Hoy el CV demuestra criterio, no escala.
5. **Una métrica para la deuda técnica**: lead time antes/después, tasa de cambio fallido, tiempo
   de mantenimiento. Es lo que le falta al ángulo más vendible del paquete.
6. **Evidencia de propiedad en producción**. Es lo que separa a un DevOps de plataforma de un
   arquitecto de infraestructura, y no está en los hechos confirmados.
7. **Recomendaciones de LinkedIn** (mínimo tres, de colegas y clientes, naming an outcome) y un
   pie de foto de perfil y un banner actualizados.
8. **Actividad en LinkedIn**: una publicación por semana sobre lo que ya sabe (Terraform,
   Kubernetes, agentes, skills) convertiría un perfil en movimiento.
9. **Inglés**: B2 declarado honestamente. Para vacantes en inglés-native, una prueba de
   conversación (B2+) quitaría una duda de screening.
10. **Una publicación del trabajo móvil** que no sea del empleador, si algún día existe. Hoy
    no se publica tienda, usuarios ni ingresos, y esa frontera se mantiene.

---

## 11. Nota sobre las herramientas

- `detect.py` (de `li-human`) da **59.3 / REVIEW** al Acerca de en español y **75.4 / PASS** en
  inglés. La nota en español viene del indicador **VOICE**, que solo reconoce pronombres y
  contracciones **en inglés**: un texto en español en primera persona no se contabiliza. Es un
  falso positivo, y la única forma de subir esa cifra sería romper la regla de estilo del
  repositorio.
- `humanize.py` **no se aplicó a los `.tex`**: reescribiría LaTeX. Solo se usó como medidor
  sobre los `.tex` y como limpiador, bloque a bloque, sobre los 25 bloques de LinkedIn.
- `li-profile` aportó la estructura (titular, "acerca de", Destacado, banner) y la disciplina de
  puntuar honestamente: una puntuación generosa no sirve de nada.
