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

AWS · Kubernetes · Terraform · Helm · Ansible · Azure DevOps

+70  microservices deployed | +20  pre-production clusters | +20  CI/CD pipelines
```

**El "+" significa "al menos".** Las cifras del banner se redondean **hacia abajo a múltiplo
de diez** y se prefijan con "+", porque las cantidades reales son aproximadas. El CV conserva
las cifras exactas: `FACTS.md` §2 dice 70 microservicios, 21 clústeres de preproducción y
~20 pipelines de CI/CD, así que "+20 clústeres" y "+20 pipelines" son flooring conservador,
no una contradicción. Si alguna vez una cifra del CV baja de un múltiplo de diez, el "+" del
banner deja de ser cierto y hay que recalcularlo.

El banner **no lleva correo**: la decisión es del 2026-10-19, y el contacto vive en el titular
y en la sección "Acerca de" de `LinkedIn_perfil_AFRV_propuesta.md`.

Si el copy cambia, hay que actualizar también el bloque "Texto para el banner" de
[`LinkedIn_perfil_AFRV_propuesta.md`](../../LinkedIn_perfil_AFRV_propuesta.md) (§5).

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
