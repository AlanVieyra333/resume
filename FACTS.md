# FACTS — fuente única de verdad de los perfiles del CV

Este archivo es la referencia para **qué es cierto** y **qué no se puede afirmar** en
los seis archivos de contenido del CV. Los perfiles lo citan en su cabecera.

Cuando cambies un dato, actualízalo aquí **primero** y luego en los perfiles.
`scripts/check-profiles.sh` verifica mecánicamente varios de estos invariantes.

---

## 1. Empleadores y fechas (invariante — idéntico en los 3 perfiles × 2 idiomas)

| Empleador | Cliente | Rol | Fechas | Ubicación |
|---|---|---|---|---|
| Veradat Smart Network S.A. de C.V. | — | DevOps Engineer | Ago 2024 – Oct 2026 | Ciudad de México |
| IDS Comercial S.A. de C.V. | Banamex | Fullstack + DevOps Engineer | Ene 2021 – Ago 2024 | México, remoto |
| Proyecto continuo (GLOBAL HITSS → Everis) | Telcel | Fullstack Software Engineer | Jul 2018 – Dic 2020 | Ciudad de México |
| GDP administración S de RL de CV (Grupo de la Parra) | — | Freelance, líder técnico | Jun 2021 – Dic 2021 | Ciudad de México |

> **El freelance se solapa con IDS Comercial (Ene 2021 – Ago 2024).** Fechas confirmadas por
> Alan el 2026-10: junio–diciembre de 2021. Fue trabajo paralelo mientras estaba contratado
> con Banamex; ambos periodos se publican tal cual. Si un reclutador pregunta, la respuesta
> es trabajo freelance simultáneo, no una discontinuidad laboral.

> **GLOBAL HITSS: Jul 2018 – Sep 2019; Everis: Sep 2019 – Dic 2020.**
> Cambio de consultora a mitad del proyecto continuo.

Eliminado de los tres perfiles en la revisión 2026-10: **Nova Solutions / Banco Multiva**
(Frontend Jr., Mar 2017 – May 2018) y **CINVESTAV** (maestría no concluida, sin grado).

---

## 2. Métricas (invariante — mismo valor en EN y ES)

| Métrica | Valor | Dónde |
|---|---|---|
| Pipelines de CI/CD mantenidos | 10 | Veradat |
| Equipos atendidos por esos pipelines | 3 (frontend, backend, QA) | Veradat |
| Despliegue del conjunto completo | 70 microservicios | Veradat |
| Reducción de tiempo de despliegue | 6 h → 1 h (≈83 %) | Veradat |
| Clústeres de QA | 9 (8 Kubernetes, 1 OpenShift) | Veradat |
| Clústeres de preproducción | 12 (4 DEV + 4 INTGR + 4 Certificación) | Veradat |
| Detección de incidentes | 60 min → 30 min (50 %) | Veradat |
| Servidores aprovisionados con Ansible | 10 | Veradat |
| Aprovisionamiento | 2 h → 20 min (≈83 %) | Veradat |
| Experiencia Python / Go | confirmada (años no publicados) | Veradat |
| Experiencia Claude Code | confirmada (tiempo no publicado) | Veradat |
| Microservicios en producción | 10 | Banamex |
| Transacciones diarias por sucursal | ≈1,000 | Banamex |
| Resolución de incidentes QA | 2–3 h promedio; hasta 1 semana en casos complejos | Banamex |
| SLA de tickets de infraestructura | 1 día (ServiceNow) | Banamex |
| Fuerza laboral cubierta por el sistema | 5,000 empleados | Freelance |

---

## 3. Hechos confirmados por RECORD (no deducidos)

### Veradat
- Diseñó y mantiene 10 pipelines de CI/CD en Azure DevOps para 3 equipos.
- Charts de Helmtablendo como **estándar de despliegue**, adoptado por los 3 equipos.
- Administra 9 clústeres de **QA** (8 Kubernetes, 1 OpenShift); readiness/liveness probes. La cifra
  corresponde al entorno de QA, no a producción. *(Corrección 2026-10: los 9 clústeres
  publicados hasta ahora como "de producción" eran de QA; el detalle de preproducción — 4 en
  DEV, 4 en INTGR, 4 en Certificación, 12 en total — se publica a partir de esta revisión.)*
- Además operó 4 clústeres de DEV, 4 de INTGR y 4 de Certificación (preproducción) — 12 en total
  sobre Kubernetes y OpenShift.
- Monitoreo y alertas con Elastic Stack en los 9 clústeres.
- Provisioning en AWS y Azure con Terraform; servicios de AWS usados: **EC2, S3, VPC, Security Groups, IAM, RDS, CloudWatch y Route 53**; gestión de secretos. *(Confirmado por Alan el 2026-10-16; antes del ajuste el CV solo declaraba Route 53 e IAM.)*
- **Backups y rollbacks de bases de datos PostgreSQL y Oracle** que soportan los 70 microservicios,
  asegurando la recuperabilidad durante despliegues y respuesta a incidentes. *(Confirmado por Alan el
  2026-10-16.)*
- Automatización con Ansible en servidores Linux.
- Scripts de automatización/integración en Python y Go. (Los años de uso no se publican en
  el CV: el resto de herramientas se lista solo por nombre, sin tiempo de experiencia, y Alan
  pidió en 2026-10 mantener ese mismo formato para no destacar Python/Go/Claude Code con un
  baremo distinto al resto.)
- Claude Code como asistente de desarrollo.
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

### Educación y certificaciones
- IPN – ESCOM, B.Sc. Computer Systems Engineering, 2014–2018.
- Java SE – Oracle Certified Associate (2013), con credencial pública.
  **Versión de la certificación confirmada por Alan el 2026-10: Java SE 6.** No se publica el
  número de versión junto al nombre porque al lado de una certificación de 2013 leería como
  desfase. La cifra queda aquí para responder con precisión si un reclutador pregunta.
- Scrum Fundamentals – SCRUMstudy (2018).
- Inglés B2 (upper intermediate). Declarado honestamente en los tres perfiles.

---

## 4. Frontera confirmed / NO declarable

Verificado como **no confirmado**. `check-profiles.sh` falla si aparece en cualquier perfil.

| No afirmar | Por qué |
|---|---|
| SLO, error budgets, objetivos de disponibilidad | Solo se confirmó guardia/on-call |
| Postmortems, RCA, runbooks | No confirmados |
| Guardia 24/7 o en rotación | La guardia fue dentro del horario laboral y sin rotación |
| **"Implementó arquitectura hexagonal"** | La revisó; la implementación fue de otra persona |
| Liderar Scrum, priorizar backlog del equipo, facilitar ceremonias | Era miembro del equipo |
| Dependencias o hitos en Microsoft Project | Solo se confirmó planear por sprint |
| Participación en auditorías o certificaciones ISO 27001 | Su rol fue implementar y operar controles |
| Autoría de políticas/estándares internos | Confirmado en general, sin ejemplo concreto. Redactar como conducta, nunca como entregable |

**Confirmado y publicado:**
- ACM–ICPC (selección de etapa, 2015–2017) y Google Code Jam (2019). Verificados en el CV
  pre-reescritura (`git show 59f3351~1:cv.tex`) y confirmados por Alan; reemplazan a los premios de
  Coding Rush (2014) y Olimpiada Mexicana (2013), que se retiraron de los tres perfiles.
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
- Gestión de stakeholders: **confirmada y publicada** en los seis archivos de contenido a partir
  de la revisión 2026-10. Ver sección 3.

---

## 4b. Texto publicable en LinkedIn

[LinkedIn_perfil_AFRV_propuesta.md](LinkedIn_perfil_AFRV_propuesta.md) contiene bloques ```text
destinados a publicarse. `scripts/check-profiles.sh` los escanea con las mismas guardarraíles que
los perfiles, salvo el chequeo de skills huérfanas (no aplica: no hay filas de skills).

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
> la cadena "dashboards and boards" / "dashboards y boards" en los seis perfiles.

**Lo que NO se generaliza** (sí aporta a quien contrata):

- Herramientas de mercado yversión: Azure DevOps, Terraform, Kubernetes, Snyk, Splunk, ServiceNow.
- Regulatory bodies del dominio: SAT, IMSS, INFONAVIT, STPS, CFDI. Dan profundidad de sector.
- Métricas: 70 microservicios, 9 clústeres, 6 h → 1 h, 1,000 transacciones/día, 5,000 empleados.
- Empleadores y clientelas: Veradat, IDS Comercial, GLOBAL HITSS, Everis, Banamex, Telcel.
- Integraciones con productos de terceros en el proyecto freelance (p. ej. **Contpaqi**): evidencia
  de trabajo real con sistemas externos.

---

## 5. Matriz de énfasis por perfil

Cada perfil conserva su propio foco sobre los mismos hechos. **No contradecirse.**

| | DevOps | DevOps/SRE Lead | Full Stack |
|---|---|---|---|
| Título | DevOps Engineer · AWS, K8s, CI/CD | DevOps/SRE Engineer Lead · Debt Remediation | Senior Full Stack Software Engineer |
| Abre con | Provisioning AWS/Terraform, velocidad de despliegue | Deuda técnica, ISO 27001, liderazgo, gobernanza | Ownership de entrega, arquitectura de microservicios |
| Hexagonal + imágenes | Una línea (ángulo infra) | Protagonista (revisión + gobernanza) | Una línea (ángulo arquitectura) |
| ISO 27001 | Una línea | Protagonista, ambas empresas | Una línea |
| Mentoring / guardia | Se omite | Protagonista | Se omite |
| POM padre Maven | Promovido (deuda técnica) | Promovido (estándar) | Se mantiene |
| Proyecto freelance | 3 bullets, comprimido | 3 bullets, elevado (compliance) | 5 bullets, completo |

---

## 6. Verificación

```bash
make check          # o: bash scripts/check-profiles.sh
```

Comprueba: fechas y empleadores consistentes, métricas iguales entre EN y ES, ausencia de
términos prohibidos, sin herramientas huérfanas en las filas de skills, y cero ocurrencias de
`Citibanamex` (el nombre correcto es **Banamex**).

Además, todos los PDFs deben quedar en **2 páginas** — es el criterio de aceptación de layout.