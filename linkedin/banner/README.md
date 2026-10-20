# Banner de LinkedIn — perfil DevOps

Imagen de portada (banner) para el perfil de LinkedIn del perfil **DevOps**, en inglés.

| Archivo | Qué es |
| --- | --- |
| `banner-devops-en.html` | **Fuente de verdad.** El diseño completo: 1584 × 396 px en HTML/CSS. Se edita aquí. |
| `banner-devops-en.png` | Export a 2× (3168 × 792 px). Es el maestro y el archivo que sube LinkedIn. |
| `banner-devops-en.jpg` | El mismo diseño en JPEG quality 90 (≈157 KB). Versión ligera para subir. |
| `render.sh` | Renderiza el HTML a PNG con un navegador Chromium en modo headless. |

## Regenerar

```bash
make banner                      # o: bash linkedin/banner/render.sh
```

Necesita un navegador con Chromium: por defecto usa Brave. Con otro navegador:

```bash
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" make banner
```

`render.sh` escribe el PNG a 2× (`--force-device-scale-factor=2`), que es como lo muestra
LinkedIn en pantallas retina. Para el JPEG:

```bash
python3 -c "from PIL import Image; Image.open('banner-devops-en.png').convert('RGB').save('banner-devops-en.jpg','JPEG',quality=90,optimize=True,progressive=True)"
```

## El copy

```text
DEVOPS ENGINEER

Scale cloud infrastructure
with CI/CD and Kubernetes

AWS · Terraform · Docker · Linux · Ansible · Jenkins · Azure DevOps

+70  microservices deployed | +20  Kubernetes clusters | +20  CI/CD pipelines | +30  shell scripts automated
```

**El "+" significa "al menos".** Las cifras del banner se redondean **hacia abajo a múltiplo
de diez** y se prefijan con "+", porque las cantidades reales son aproximadas. El CV conserva
las cifras exactas: `FACTS.md` §2 dice 70 microservicios, 21 clústeres de preproducción,
~20 pipelines de CI/CD y 30 procesos automatizados con shell scripting (20 en Veradat y 10 en
IDS Comercial), así que "+20 clústeres", "+20 pipelines" y "+30 scripts" son flooring
conservador, no una contradicción. Si alguna vez una cifra del CV baja de un múltiplo de diez,
el "+" del banner deja de ser cierto y hay que recalcularlo.

**"Kubernetes clusters" y no "pre-production clusters"** (decisión del 2026-10-19): OpenShift
es una distribución de Kubernetes, así que los 21 clústeres de preproducción que administra en
Veradat (13 sobre Kubernetes y 8 sobre OpenShift) se cuentan como clústeres de Kubernetes. El
CV sí publica el desglose por entorno.

### La cinta de herramientas

**Regla:** a la cinta solo entra lo que se puede defender veinte minutos en una entrevista, en
el nivel de "esto lo hice yo, a esta escala". El banner no es una lista: es una promesa de
screening, y una palabra mal puesta te mete a una entrevista que no quieres.

Orden actual (decisión del 2026-10-20), leído como cadena: **nubes → cómo se define → cómo se
empaqueta → sobre qué corre → el "y además" → las dos plataformas de entrega**.

| Palabra | Evidencia en `FACTS.md` |
| --- | --- |
| AWS | §3: EC2, S3, VPC, Security Groups, IAM, RDS, CloudWatch, Route 53 |
| Terraform | §3: aprovisionamiento en AWS y Azure con Terraform |
| Docker | §3: imagen Docker por combinación tecnológica; contenedores sobre Kubernetes |
| Linux | §3: automatización con Ansible sobre servidores Linux (10 servidores) |
| Ansible | §3: configuración automatizada, 2 h → 20 min |
| Jenkins | §3: pipelines de CI/CD de la aplicación bancaria (IDS Comercial / Banamex) |
| Azure DevOps | §3: 20 pipelines de CI/CD para 3 equipos (Veradat) |

**"Azure DevOps", no "Azure"** (decisión del 2026-10-20): el footprints de Azure cloud es
real pero fino (máquinas virtuales, balanceadores y gestión de secretos, con Terraform), frente
a los ocho servicios de AWS que sí se nombran. Poner "Azure" en la banda hace que un
reclutador de una empresa Azure lo lea como "multi-cloud engineer" y te pregunte por AKS,
Entra ID, ARM y Landing Zones: un filtro al que uno entra por la puerta de atrás. "Azure
DevOps" es un producto de Microsoft que corre sobre cualquier nube, es lo que se opera hoy, y
conserva la palabra "Azure" para el ojo que filtra por ella. El multi-nube real se publica en
el CV, que ya lo pondera con honestidad.

**"Docker", no "Kubernetes", en la cinta** (decisión del 2026-10-20): con "Kubernetes"
repetido en el titular y en la cinta, la palabra de mayor peso del banner se gastaba dos veces
en 396 px. Kubernetes sigue presente en el titular y en la tarjeta de métrica, donde es el dato
que sí cuenta.

**Palabras que no están y por qué:** Prometheus, Grafana, ArgoCD, GitLab CI, Vault, EKS y
service mesh no están confirmadas en `FACTS.md` y no se pueden publicar. El equivalente
empresarial que sí se tiene es ELK + Splunk, que en banca y empresa latinoamericana se busca
más que Prometheus. Ese hueco (GitOps y observabilidad) es un objetivo de aprendizaje, no una
edición de banner.

El banner **no lleva correo**: la decisión es del 2026-10-19, y el contacto vive en el titular
y en la sección "Acerca de" de `linkedin/perfil.md`.

Si el copy cambia, hay que actualizar también el bloque "Texto para el banner" de
[`linkedin/perfil.md`](../perfil.md) (§5).

## Por qué estos colores

La paleta sale del propio CV, para que el banner y los PDFs se lean como un solo paquete:

| Color | Uso | Origen |
| --- | --- | --- |
| `#1A3A5C` | Base del degradado | `headingcolor` en `style.cls` |
| `#0F2740` / `#08182B` | Sombras del degradado | Derivados del anterior |
| `#C9C9C9` → `#A9C0D8` | Texto secundario | `designbandtext` en `styles/styledesign.tex` |
| `#38BDF8` / `#7DD3FC` | Acento único | Añadido: el color que faltaba en el CV |

La tipografía es **Helvetica Neue**, la misma familia que usa el CV (`\usepackage{helvet}`).

## Zonas seguras (por qué el diseño está donde está)

- **x 0–460 px**: zona de la foto. LinkedIn monta la foto de perfil encima, en el ángulo
  inferior izquierdo, así que ahí solo va el motivo de topología, con poco contraste.
- **x 472–1260 px**: el texto. Entra completo en el recorte que hace LinkedIn en móvil
  (recorte central de ≈1188 px), comprobado con una simulación.
- **Hairline vertical en x = 440 px**: separa la zona de la foto del bloque de texto.

El motivo es una topología de clúster dibujada a mano (nodos y enlaces en SVG), no una foto
de stock ni un skyline: la rúbrica de `li-profile` penaliza exactamente eso.

## Calificación del banner

Contra la rúbrica de `li-profile` (ítem `banner`, 6 puntos) y una rúbrica propia de 10:

| Criterio | Puntos |
| --- | --- |
| Una línea de posicionamiento que dice qué haces y con qué | 2/2 |
| Prueba cuantitativa (métricas reales, no adjetivos) | 2/2 |
| Legibilidad: jerarquía, contraste, tamaño mínimo al 50 % | 2/2 |
| Zonas seguras: foto de perfil y recorte móvil | 2/2 |
| Identidad: paleta del CV, sin plantilla genérica | 2/2 |
| Una forma de contactar | 0/2 |

**8/10.** Lo único que falta es la línea de contacto: si se quiere el 10/10, se añade una
línea discreta con el correo o con `github.com/AlanVieyra333` debajo de la fila de métricas.
Por ahora se deja sin contacto por decisión del 2026-10-19: el perfil ya tiene correo,
titular y un CTA al final del "Acerca de", y en el banner las métricas pesan más.
