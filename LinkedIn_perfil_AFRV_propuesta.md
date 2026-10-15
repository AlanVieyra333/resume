# Propuesta de perfil de LinkedIn - Alan Fernando Rincón Vieyra

Revisión: 14 de octubre de 2026. Homologada con [main.tex](main.tex) y los seis perfiles de contenido: [lang/es.tex](lang/es.tex), [lang/en.tex](lang/en.tex), [lang/lead/es.tex](lang/lead/es.tex), [lang/lead/en.tex](lang/lead/en.tex), [lang/fullstack/es.tex](lang/fullstack/es.tex) y [lang/fullstack/en.tex](lang/fullstack/en.tex).

Objetivo: oportunidades de DevOps, Cloud Engineering y Platform Engineering con énfasis en AWS, y roles de liderazgo técnico (DevOps/SRE Lead) donde pesa la remediación de deuda técnica, los estándares y el cumplimiento. El posicionamiento combina infraestructura como código, operación de producción, automatización de entregas, gobierno técnico y experiencia previa en desarrollo. Los cargos, las fechas y las cifras proceden del CV; las notas de revisión no forman parte del texto para publicar.

La fuente de verdad de los hechos, las métricas y **los límites de lo declarable** está en [FACTS.md](FACTS.md). Cualquier texto de este documento debe respetar esa frontera: no se afirma SLOs ni error budgets, ni postmortems o runbooks, ni que se implementara la arquitectura hexagonal (se revisó), ni auditoría o certificación ISO 27001 (el rol fue implementar y operar controles). Las métricas de despliegue y aprovisionamiento incorporan las aclaraciones del usuario: conjunto completo de 70 microservicios y conjunto de 10 servidores, respectivamente.

## 1. Titular: tres opciones

**Recomendada: A.** Coloca AWS y Terraform al inicio para mejorar la coincidencia con búsquedas de infraestructura en AWS, y conserva CI/CD y Kubernetes como evidencia del alcance DevOps. Las métricas de mejora funcionan mejor en Acerca de y Experiencia, donde tienen suficiente contexto. Elegir una opción por idioma.

### A. DevOps y entrega de software

Español:

```text
DevOps Engineer | AWS y Terraform | CI/CD para 70 microservicios | 9 clústeres Kubernetes/OpenShift | Helm, Ansible y Azure DevOps
```

English:

```text
DevOps Engineer | AWS and Terraform | CI/CD for 70 microservices | 9 Kubernetes/OpenShift clusters | Helm, Ansible and Azure DevOps
```

### B. AWS e infraestructura como código

Español:

```text
DevOps Engineer | Infraestructura en AWS con Terraform | Route 53 e IAM | Kubernetes, OpenShift, Helm y Ansible | CI/CD con Azure DevOps
```

English:

```text
DevOps Engineer | AWS infrastructure with Terraform | Route 53 and IAM | Kubernetes, OpenShift, Helm and Ansible | CI/CD with Azure DevOps
```

### C. AWS y trayectoria en desarrollo

Español:

```text
DevOps Engineer | AWS, Terraform y Kubernetes | Experiencia en Java/Spring Cloud | CI/CD, observabilidad e infraestructura como código
```

English:

```text
DevOps Engineer | AWS, Terraform and Kubernetes | Java/Spring Cloud background | CI/CD, observability and infrastructure as code
```

## 2. Acerca de

### Español

```text
Si tu equipo necesita aprovisionar infraestructura en AWS, automatizar entregas y operar microservicios en producción, puedo aportar experiencia con Terraform, CI/CD y Kubernetes.
En Veradat reduje de 6 horas a 1 hora el tiempo de despliegue del conjunto completo de 70 microservicios mediante CI/CD para 3 equipos.

Aprovisioné infraestructura en AWS y Azure con Terraform, desde máquinas virtuales y balanceadores hasta gestión de secretos. En AWS trabajé con Route 53 e IAM. Implementé y operé controles ISO 27001 en Veradat y en Banamex.

También administro 9 clústeres: 8 Kubernetes y 1 OpenShift. Implementé monitoreo y alertas con Elastic Stack y reduje el tiempo de detección de incidentes de 60 a 30 minutos. Además, promoví charts de Helm como estándar de despliegue del equipo y generé la matriz de imágenes Docker que permite a cada microservicio cambiar de tecnología.

Coordino la interlocución técnica con stakeholders del cliente, incluido el reporte formal de seguridad que recibe su área de seguridad, y entre los 3 equipos (frontend, backend, QA) a través de dashboards y boards de Azure DevOps y una wiki compartida como canal asincrónico.

Acompaño a ingenieros de los equipos de frontend, backend y QA: revisiones de código y diseño, decisiones técnicas e incorporación de nuevos miembros. Vengo del desarrollo de software; empecé en 2017.

Si estás incorporando un DevOps Engineer o liderando remediación de deuda técnica y estándares, conversemos por LinkedIn.
```

### English

```text
If your team needs to provision AWS infrastructure, automate delivery, and run microservices in production, I bring experience with Terraform, CI/CD, and Kubernetes.
At Veradat, I cut the time to deploy the complete set of 70 microservices from 6 hours to 1 hour through CI/CD for 3 teams.

I provisioned AWS and Azure infrastructure using Terraform, including virtual machines, load balancers, and secrets management. On AWS, I worked with Route 53 and IAM. I implemented and operated ISO 27001 controls at Veradat and at Banamex.

I also manage 9 clusters: 8 Kubernetes and 1 OpenShift. I implemented Elastic Stack monitoring and alerts, cutting incident detection time from 60 to 30 minutes. I promoted Helm charts as the team's deployment standard and produced the Docker image matrix that lets each microservice swap its technology.

I coordinate technical communication with client stakeholders, including the formal security reporting the client's security team receives, and across the 3 teams (frontend, backend, QA) through Azure DevOps dashboards and boards and a shared wiki as an asynchronous channel.

I mentor engineers across the frontend, backend and QA teams: code and design reviews, technical decision-making, and onboarding. I come from software development; I started in 2017.

If you're hiring a DevOps Engineer or leading technical debt remediation and standards, let's connect here on LinkedIn.
```

## 3. Experiencia

Usar el empleador en el campo Empresa y señalar al cliente en la descripción. Las traducciones conservan el alcance de los cargos del CV.

### Ingeniero DevOps / DevOps Engineer

**Empresa:** Veradat Smart Network S.A. de C.V. · **Periodo:** agosto de 2024 - actualidad · **Ubicación:** Ciudad de México. Modalidad no especificada en el CV.

Español:

```text
Aprovisioné infraestructura en AWS y Azure con Terraform, desde máquinas virtuales y balanceadores hasta gestión de secretos. En AWS utilicé Route 53 e IAM. También administro 9 clústeres de producción: 8 Kubernetes y 1 OpenShift.

- Diseñé y mantuve 10 pipelines de CI/CD en Azure DevOps para 3 equipos: frontend, backend y QA. El tiempo de despliegue del conjunto completo de 70 microservicios pasó de 6 horas a 1 hora: aproximadamente un 83% menos. Desarrollé y promoví charts de Helm como estándar de despliegue del equipo.
- Revisé la arquitectura hexagonal del equipo, que desacopla cada microservicio de sus dependencias tecnológicas (PostgreSQL, Oracle, RabbitMQ, Kafka, IBM MQ y SQS), y generé la imagen Docker para cada combinación tecnológica que cada microservicio requiere.
- Implementé y operé controles ISO 27001 en gestión de secretos, control de acceso en nube y escaneo de dependencias. Remedié vulnerabilidades críticas y altas detectadas por SonarQube Cloud, Snyk y Mend mediante actualizaciones de paquetes del sistema operativo y dependencias Maven.
- Acompaño a ingenieros de los equipos de frontend, backend y QA: revisiones de código y diseño, decisiones técnicas e incorporación de nuevos miembros al equipo.
- Implementé monitoreo y alertas con Elastic Stack en los 9 clústeres y reduje el tiempo de detección de incidentes de 60 a 30 minutos. Incorporé readiness/liveness probes para controlar la incorporación de instancias al tráfico y su recuperación durante actualizaciones progresivas. Cubro guardia para incidentes en producción dentro del horario laboral.
- Automaticé la configuración con Ansible en servidores Linux. Aprovisionar el conjunto de 10 servidores pasó de tomar 2 horas a 20 minutos.
- Coordiné la interlocución técnica con stakeholders del cliente, incluido el reporte formal de seguridad que recibe su área de seguridad, y entre los 3 equipos (frontend, backend, QA) mediante dashboards y boards de Azure DevOps y una wiki compartida como canal asincrónico. El equipo trabaja con Scrum, en el que participo como miembro.
```

English:

```text
I provisioned AWS and Azure infrastructure using Terraform, including virtual machines, load balancers, and secrets management. On AWS, I worked with Route 53 and IAM. I also manage 9 production clusters: 8 Kubernetes and 1 OpenShift.

- Designed and maintained 10 Azure DevOps CI/CD pipelines for 3 teams: frontend, backend and QA. The time to deploy the complete set of 70 microservices fell from 6 hours to 1 hour: approximately 83% less time. Built and promoted Helm charts as the team's deployment standard.
- Reviewed the team's hexagonal architecture, which decouples each microservice from its technology dependencies (PostgreSQL, Oracle, RabbitMQ, Kafka, IBM MQ and SQS), and produced the Docker image for every technology combination each microservice requires.
- Implemented and operated ISO 27001 controls across secret management, cloud access control and dependency scanning. Remediated critical and high-severity vulnerabilities identified by SonarQube Cloud, Snyk and Mend through OS package and Maven dependency updates.
- Mentor engineers across the frontend, backend and QA teams: code and design reviews, technical decision-making, and onboarding new team members.
- Implemented Elastic Stack monitoring and alerts across all 9 clusters, cutting incident detection time from 60 to 30 minutes. Added readiness/liveness probes to control when instances receive traffic and trigger recovery during rolling updates. Carried on-call for production incidents within working hours.
- Automated configuration with Ansible on Linux servers, cutting provisioning time for the entire set of 10 servers from 2 hours to 20 minutes.
- Coordinated technical communication with client stakeholders, including the formal security reporting the client's security team receives, and across the 3 teams (frontend, backend, QA) through Azure DevOps dashboards and boards and a shared wiki as an asynchronous channel. The team works in Scrum, in which I participate as a team member.
```

### Ingeniero Fullstack + DevOps / Fullstack + DevOps Engineer

**Empresa:** IDS Comercial S.A. de C.V. · **Cliente:** Banamex · **Periodo:** enero de 2021 - agosto de 2024 · **Ubicación:** México, remoto.

Español:

```text
Desarrollo full stack y CI/CD para aplicaciones bancarias internas de Banamex, a través de IDS Comercial.

- Desarrollé y mantuve 10 microservicios Java/Spring Cloud para flujos de trabajo de ejecutivos bancarios. Esos flujos atendían aproximadamente 1,000 transacciones diarias por sucursal.
- Estandaricé los microservicios con un POM padre multimódulo de Maven y gestión compartida de dependencias, garantizando un versionado consistente y reduciendo el esfuerzo de actualización en todos los servicios.
- Me apegaba a los controles ISO 27001 en ese entorno bancario durante toda mi colaboración.
- Construí pipelines de CI/CD con Azure DevOps y Jenkins para automatizar compilaciones y despliegues. Desarrollé funcionalidades frontend con React, Node.js y TypeScript, y administré esquemas Oracle.
- Atendí incidentes del entorno de QA, con un tiempo promedio de resolución de 2 a 3 horas; los casos complejos podían tomar hasta una semana. Monitoreé producción con Splunk y resolví tickets de infraestructura en ServiceNow conforme a un SLA de 1 día.
```

English:

```text
Full stack development and CI/CD for internal banking applications at Banamex, through IDS Comercial.

- Developed and maintained 10 Java/Spring Cloud microservices for banking-executive workflows. Those workflows handled approximately 1,000 transactions per day per branch.
- Standardised the microservices through a multi-module Maven POM parent and shared dependency management, ensuring consistent versioning and reducing upgrade effort across all services.
- Adhered to the ISO 27001 controls in that banking environment throughout the engagement.
- Built Azure DevOps and Jenkins CI/CD pipelines to automate builds and deployments. Developed frontend features with React, Node.js, and TypeScript, and administered Oracle schemas.
- Handled QA environment incidents with an average resolution time of 2 to 3 hours; complex cases could take up to one week. Monitored production with Splunk and resolved infrastructure tickets in ServiceNow under a 1-day SLA.
```

### Ingeniero de Software Fullstack / Fullstack Software Engineer

**Empresa:** Everis BPO México, S. de R.L. de C.V. · **Cliente:** Telcel · **Periodo:** septiembre de 2019 - diciembre de 2020 · **Ubicación:** Ciudad de México.

El proyecto fue continuo desde julio de 2018 hasta diciembre de 2020, con cambio de consultora en septiembre de 2019. El alcance técnico se describe como trabajo del proyecto completo, sin asignar entregables a una fase que no está documentada.

Español:

```text
Continué el proyecto de desarrollo e integración para Telcel tras cambiar de GLOBAL HITSS a Everis en septiembre de 2019.

Mi trabajo durante el proyecto completo, de julio de 2018 a diciembre de 2020, incluyó:

- Construí una capa de integración con Java, Spring Cloud y JPA que tradujo protocolos de sistemas legados a APIs REST para conectarlos con servicios modernos.
- Implementé pipelines de CI/CD y contenericé el servicio con Docker sobre Kubernetes. Automaticé procesos operativos con Bash y gestioné repositorios de código y artefactos con GitHub y Nexus.
- Desarrollé microservicios y funcionalidades frontend con React, Node.js y TypeScript; administré bases de datos Oracle.
```

English:

```text
Continued the Telcel development and integration project after transferring from GLOBAL HITSS to Everis in September 2019.

My work across the full project, from July 2018 to December 2020, included:

- Built an integration layer with Java, Spring Cloud, and JPA that translated legacy protocols into REST APIs, connecting existing systems with modern services.
- Implemented CI/CD pipelines and containerized the service with Docker on Kubernetes. Automated operational processes with Bash and managed code and artifact repositories with GitHub and Nexus.
- Developed microservices and frontend features with React, Node.js, and TypeScript; administered Oracle databases.
```

### Ingeniero de Software Fullstack / Fullstack Software Engineer

**Empresa:** GLOBAL HITSS · **Cliente:** Telcel · **Periodo:** julio de 2018 - septiembre de 2019 · **Ubicación:** Ciudad de México.

Español:

```text
Primera etapa del proyecto de desarrollo e integración de sistemas de telecomunicaciones para Telcel. En septiembre de 2019 cambié de consultora a Everis y continué en el mismo proyecto hasta diciembre de 2020. El alcance técnico del proyecto completo está descrito en la experiencia de Everis.
```

English:

```text
First stage of the telecom systems development and integration project for Telcel. In September 2019, I transferred to Everis and continued on the same project until December 2020. The technical scope of the full project is described under the Everis experience.
```

## 4. Aptitudes

Priorizar **Amazon Web Services (AWS)**, **Terraform** y **Kubernetes**. Asociarlas con la experiencia de Veradat y solicitar validaciones de personas que hayan trabajado directamente contigo en esas áreas.

Complementarias: Continuous Integration and Continuous Delivery (CI/CD), Azure DevOps, OpenShift, Helm, Ansible, Elastic Stack, Microsoft Azure, Docker, Jenkins, Linux, Java y Spring Cloud. Para roles de liderazgo técnico, sumar **Information Security Management (ISO 27001)**, **hexagonal architecture**, **Scrum** y **Microsoft Project**. La experiencia en desarrollo respalda el enfoque DevOps; no hace falta trasladar todas las herramientas del CV al titular.

## 5. Destacado y banner

### Destacado

| Prioridad | Pieza y texto sugerido | Estado |
| --- | --- | --- |
| 1 | **Despliegue completo de 70 microservicios: de 6 horas a 1 hora.** Caso técnico sobre pipelines de Azure DevOps y estandarización con Helm. | Por preparar. Documentar decisiones y alcance antes de desarrollar el caso. |
| 2 | **Arquitectura hexagonal y matriz de imágenes Docker.** Caso técnico sobre cómo desacoplar un microservicio de sus dependencias tecnológicas (PostgreSQL, Oracle, RabbitMQ, Kafka, IBM MQ, SQS) y generar una imagen por combinación. | Por preparar. Documentar la decisión de arquitectura y su efecto operativo, sin código del empleador. |
| 3 | **Infraestructura reproducible en AWS con Terraform.** Demostración pública con Route 53 e IAM, README y pasos reproducibles, sin datos ni código de empleadores. | Por crear; documentar arquitectura, decisiones y controles de seguridad. |
| 4 | **Alan Rincón Vieyra · DevOps Engineer.** CV actualizado con datos de contacto. | Usar el PDF generado desde la versión actual de `main.tex`. Para roles de liderazgo, usar el perfil `Resume_DevOpsLead_AFRV_{EN,ES}.pdf`. |

El repositorio del proyecto de Grupo de la Parra es privado, según el CV original. Su descripción puede servir como evidencia de alcance; no se presenta como demostración pública disponible. Cuando haya publicaciones y métricas propias, se podrá elegir una publicación para Destacado con base en esos resultados.

### Texto para el banner

Español:

```text
AWS, CI/CD y Kubernetes para plataformas de producción
alan.vieyra376@gmail.com
```

English:

```text
AWS, CI/CD and Kubernetes for production platforms
alan.vieyra376@gmail.com
```

Usar una frase legible y el contacto, con espacio para la foto de perfil. La imagen del banner queda por producir.

## 6. Proyecto e información adicional

### Sistema de Gestión de Cumplimiento de la Ley de Subcontratación

**Cliente:** Grupo de la Parra · **Modalidad:** freelance · **Periodo:** junio de 2021 - diciembre de 2021 · **Responsabilidad:** liderazgo técnico. El periodo se solapa con el de Banamex (enero 2021 - agosto 2024): fue trabajo freelance paralelo.

Español:

```text
Lideré el diseño técnico y la arquitectura de una plataforma en producción para gestionar el cumplimiento de la Ley Federal del Trabajo en materia de subcontratación, cubriendo una fuerza laboral subcontratada de 5,000 empleados. Desarrollé la plataforma de extremo a extremo con Angular, Java Spring, PostgreSQL y APIs REST, y acompañé al equipo del cliente durante el diseño.
```

English:

```text
Led the technical design and architecture of a production platform that managed compliance with Mexico's Federal Labor Law on Subcontracting, covering a subcontracted workforce of 5,000 employees. Built the platform end to end with Angular, Java Spring, PostgreSQL, and REST APIs, and mentored the client team through the design.
```

Los 5,000 empleados describen la fuerza laboral cubierta por el sistema, sin afirmar que fueran usuarios activos o concurrentes.

### Educación

| Institución | Español | English | Periodo |
| --- | --- | --- | --- |
| IPN - Escuela Superior de Cómputo (ESCOM) | Ingeniería en Sistemas Computacionales. | B.Sc. in Computer Systems Engineering. | 2014 - 2018 |

CINVESTAV - IPN (maestría en Ciencias de la Computación, área de Inteligencia Artificial, 2019-2020) se retiró de los tres perfiles del CV: el programa no se concluyó y no se obtuvo grado. Si la cuenta de LinkedIn aún lo muestra como `2019-Present`, sustituir ese periodo por **2019-2020** y decidir con cuidado si se conserva: en el CV ya no aparece.

### Certificación, idiomas y reconocimientos

- **Java SE, Certificado Asociado / Certified Associate.** Oracle, 2013. Denominación conservada del CV; verificar el título exacto en la credencial antes de ampliarlo.
- **Scrum Fundamentals.** SCRUMstudy, 2018.
- **Español:** nativo. **Inglés:** B2, intermedio alto / upper intermediate.
- **Reconocimientos:** participante en Google Code Jam (2019) y equipo de selección de etapa del ACM-ICPC, International Collegiate Programming Contest (2015-2017).

### Contacto

- **Nombre:** Alan Fernando Rincón Vieyra.
- **Ubicación:** Ciudad de México, México.
- **Correo:** alan.vieyra376@gmail.com.
- **LinkedIn:** linkedin.com/in/AlanVieyra333.
- **GitHub:** github.com/AlanVieyra333.

## 7. Criterios editoriales y validación

Se mantienen los criterios pertinentes de los 11 skills `li-*` revisados en la primera versión. `li-profile` orienta el posicionamiento y la estructura; `li-human`, la revisión de estilo. De `li-post`, `li-repurpose` y `li-carousel` se toman la especificidad y los posibles materiales de prueba. `li-plan` aporta los ejes de contenido; `li-audit` exige resultados propios antes de atribuir rendimiento. `li-comment`, `li-reply`, `li-dm` y `li-inbox` refuerzan la pertinencia y claridad del contacto. No se cuenta como producido material de publicaciones o mensajería que no forma parte de este documento.

La evaluación del perfil publicado sigue pendiente para foto, banner, Destacado, recomendaciones, validaciones de aptitudes y actividad reciente. Las puntuaciones de la versión anterior describían aquella redacción; esta revisión prioriza la correspondencia entre CV y LinkedIn y no reutiliza esas cifras como una evaluación nueva.

- Los 20 bloques para copiar se revisaron con `humanize.py` en la revisión del 6 de octubre. Los bloques añadidos o reescritos en la homologación del 14 de octubre (Acercade de, experiencia de Veradat y Banamex, proyecto freelance, certificaciones y reconocimientos) **no se han vuelto a pasar por `humanize.py`**: conviene hacerlo antes de publicar.
- Caracteres de los titulares, español / inglés: **A 130 / 131**, **B 136 / 138**, **C 134 / 128**. Todos quedan por debajo de 220.
- Acerca de tras la homologación: **1,206 caracteres en español** y **1,142 en inglés**, incluidos espacios y saltos de línea, por debajo del objetivo editorial de 1,400.

`detect.py`, comparando Acerca de con la propuesta del 6 de octubre:

| Idioma | Antes | Ahora |
| --- | --- | --- |
| Español | 60.0, REVIEW | pendiente de re-ejecutar |
| English | 77.2, PASS | pendiente de re-ejecutar |

Estas son heurísticas locales, no una prueba de autoría. Las reglas de pronombres y contracciones están orientadas al inglés, por lo que la puntuación de voz no sirve para evaluar español. La revisión manual prioriza claridad, naturalidad y fidelidad a la experiencia.
