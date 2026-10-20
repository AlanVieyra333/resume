# Foto de perfil — qué se hizo, qué falta y cómo se rehace

La foto de este repo es la que usan el CV (variante con diseño, en círculo de 3 cm) y la que
se sube a LinkedIn. Este documento deja por escrito qué se corrigió por software, qué no se
puede corregir por software, y el guion exacto para la siguiente sesión de fotos.

## Los dos archivos

| Archivo | Uso | Tamaño |
| --- | --- | --- |
| `profile.jpg` | La que incrusta el CV (círculo de 3 cm sobre la banda oscura) | 1086×1086 |
| `profile-original.jpg` | El original sin tocar. **Fuente del script, no se edita nunca** | 1086×1086 |
| `linkedin/profile-linkedin.jpg` | La que se sube a LinkedIn | 1200×1200 |

Todo el retoque vive en `scripts/retouch_profile.py`:

```bash
python3 scripts/retouch_profile.py          # regenera profile.jpg y linkedin/profile-linkedin.jpg
python3 scripts/retouch_profile.py --debug  # además deja las máscaras en out/
```

El script es idempotente: siempre parte de `profile-original.jpg`, así que se puede ajustar un
parámetro y volver a ejecutar sin acumular retoques.

## Qué se corrigió (2026-10-20)

| Cambio | Por qué |
| --- | --- |
| **Recomposición**: sujeto escalado al 88 % y pegado al borde inferior, con 14 % de aire arriba | En la original el pelo quedaba a 2 % del borde: dentro del círculo de 3 cm del CV se veía encajonado. Ahora la cabeza ocupa el 63 % del círculo y respira |
| **Fondo**: blanco roto (255 plano) → gris neutro con degradado vertical (#FAFAFB → #E9EBEE) | El blanco plano hacía que la foto pareciera un recorte pegado. El gris separa la camisa blanca del fondo y da profundidad de estudio |
| **Halo del pelo disuelto** | La compresión JPEG dejaba un aro claro alrededor del pelo. Sobre la banda oscura (#2B2B2B) del CV ese aro se leía como un anillo brillante alrededor de la cabeza |
| **Pelo** | Se quitan los pelos sueltos aislados, se define el contraste de los mechones y se baja el "picor" de la cresta sin cambiar la forma |
| **Piel** | Se comprime el brillo de la zona T (frente y nariz) con un peso que sigue a la propia alta luz, así que no deja parche; se iguala el tono de las mejillas sin borrar los poros |
| **Barba** | Se baja el contraste del vello para que la barba de dos días se lea como intencional y no como descuido. No se borra: borrarla deja una mancha |
| **Ojos** | Nitidez selectiva en las dos regiones oculares |
| **Camisa** | Menos arrugas, un punto más de brillo, cuello más limpio |
| **Modelado** | Dodge muy leve en pómulo y mentón, burn en los laterales: la luz era plana y la cara no tenía volumen |

Resultado: 16 PDFs en 2 páginas, círculo limpio, barra lateral sin recortes.

## Lo que NO se puede corregir por software

Tres cosas decides tú, no el editor, y son justo las que más mueven la aguja:

1. **La expresión.** La foto actual es seria, con la boca cerrada. Es el mayor límite del
   conjunto y no hay filtro que lo arregle sin deformar la boca.
2. **El corte de pelo.** Se puede peinar digitalmente (quitar sueltos, tamear el picor), pero
   cambiar un corte exige una scissors real.
3. **La barba.** Se suaviza el contraste, pero un afeitado limpio o una barba bien dibujada
   solo salen en la toma.

## Las dos preguntas que se hicieron, respondidas

**¿Saco?** No. En un perfil de IT un traje sobre esta foto se lee como disfraz y resta: la
señal que importa es que eres la persona que entrega, no que vas a una junta. Además, un saco
"colado" por software sobre los hombros se ve de cartón (solapines sin volumen, costuras
visibles, luz descuadrada) y arruina la credibilidad de todo lo demás. Lo que sí suma es una
camisa limpia, de un solo color, bien planchada. Si la foto actual se hace con saco, se hace
con saco de verdad.

**¿Fondo?** El degradado neutro, no un paisaje difuminado. Un fondo de oficina o un paisaje
enfoque bokeh compite con la cara cuando LinkedIn la reduce a 40 px en un avatar, y en el
círculo de 3 cm del CV cualquier elemento reconocible detrás de la cabeza distrae. El fondo
correcto es el que no se nota: un degradado neutro, dos pasos más oscuro que la camisa.

## Guion para la sesión de fotos (30 minutos)

### Vestuario
- Camisa de un solo color, azul medio o gris claro. Sin rayas, sin cuadros, sin estampado.
- Sin corbata, pero **con el botón superior cerrado**. El cuello abierto de par en par es
  estética "startup 2014"; cerrarlo define la mandíbula y es lo que más envejece el look hacia
  senior.
- Camisa planchada: el cuello es lo primero que mira un reclutador.
- Sin saco (ver arriba).

### Pelo

Diagnóstico de la foto actual: pelo negro texturizado con volumen alto, puntas separadas y
"picadas" en la cresta, raya aproximadamente al centro y **costados más anchos que la cara**.
En un círculo de 3 cm eso produce el efecto casco: el pelo define la silueta y el rostro se
pierde dentro.

| Zona | Qué pedir | Por qué |
| --- | --- | --- |
| Cresta superior | Bajar el volumen ~1 cm y **texturizar con spray mate**, eliminando las puntas separadas | Esas puntas "picadas" son lo primero que se lee como descuido a 40 px |
| Raya | **Raya lateral baja**, nunca al centro | La raya al centro abre la frente en dos y ensancha la cara |
| Costados | **Degradado bajo o skin fade corto** | El cambio de mayor impacto: hoy el pelo es más ancho que la cara. Al estrecharlo, la cara manda en la silueta |
| Patillas | **Decididas: cortas y con línea limpia** | Ahora están a media altura, el estado "a medio hacer" |
| Nuca y línea de frente | Limpias | Se ven a 40 px |

Mantener el largo de arriba: da altura de cabeza y separa el pelo del fondo. Lo que sobra es
**anchura** y **puntas sueltas**, no largo.

### Barba

Estado actual: bigote en sombra + una mancha oscura en el mentón (perilla), con mejillas y
mandíbula limpias. Es el peor de los tres estados posibles: beard no. Se lee como "empecé a
dejar barba y se me olvidó", y es el punto que más "sin decidir" transmite de toda la foto.

La cara es **redonda y con mejillas anchas**, lo que juega a favor de la barba: un contorno de
barba le da estructura diagonal a la mandíbula y resta años. La perilla actual, al contrario,
acorta el mentón.

**Recomendación: perilla completa de 3–4 mm, con borde duro en la mandíbula y la mejilla, bigote
unido al mentón y cuello limpio.**

**Condición:** tiene que tener densidad. Si a las 3 semanas se ve rala en mejillas y labio
superior, entonces **afeitado limpio** gana — una barba completa y rala se ve peor que no
tener barba. Prueba de decisión: déjala crecer 3 semanas a 5 mm y revisa la densidad de
barbilla y mejillas; si hay huecos, afeita.

Nunca dejar la perilla sola: o se completa o se quita.

### Orden de ejecución

El orden importa, y es donde la gente falla:

1. **Semana 0** — corte (degradado, raya lateral baja, textura) + barba a 3 mm. No afeitar el
   mismo día: se llega a la sesión sin barba y sin margen para que crezca.
2. **Semana 2–3** — la barba llega a largo y el pelo se asienta. El peinado se ve bien en este
   punto, no en el día de la peluquería.
3. **Semana 3** — sesión de fotos, 30 min, con la camisa correcta.

### Luz
- Ventana grande a 45° y ligeramente por encima de la línea de los ojos, del lado izquierdo de
  la cámara. Es la diferencia entre cara con volumen y cara plana.
- Un reflector blanco (o una hoja de papel) al otro lado, para rellenar las sombras sin
  subirlas.
- **Sin flash directo ni aro frontal**: aplanan. La foto actual es exactamente eso.
- Fondo a 1,5–2 m, iluminado dos pasos más oscuro que la cara, sin línea de horizonte visible.

### Poses
- Hombros a 20–30° de la cámara, no de frente. De frente se pierde el volumen.
- Barbilla un poco hacia adelante y un poco hacia abajo: define la mandíbula.
- Mira a la cámara, no a un punto al lado.
- Cuello relajado, hombros bajos.

### Expresión

El problema de la foto actual no es la ausencia de sonrisa: es que los **labios están
comprimidos** y los **ojos muy abiertos con las cejas elevadas**. Eso se lee como
"alerta/inquieto", no como serio. Una cara seria bien hecha suma; la actual transmite tensión.

- **Media sonrisa de boca cerrada**, con las comisuras levantadas. No hace falta enseñar dientes:
  en un retrato de LinkedIn una sonrisa con boca abierta se lee como foto de empresa.
- Que la sonrisa **llegue a los ojos**: suben las mejillas y se forma el párpado inferior. Sonreír
  solo con la boca se ve falsa.
- **No digas "sonría"**. El fotógrafo dispara 10 fotos seguidas mientras tú vas del estado "algo
  gracioso" al neutral, y se elige la de un segundo antes de que se borre la sonrisa: ahí está la
  expresión natural.

### Cámara
- 85–105 mm equivalentes. Un gran angular de cerca deforma el rostro.
- f/4–f/5,6: suficiente para que la cara y las orejas estén nítidas, con el fondo desenfocado.
- Cámara a la altura de los ojos.
- Trípode y disparador remoto: la postura se nota si el fotógrafo te habla durante el disparo.

### Encuadre
Cuadrado 1:1, con estas proporciones (miden sobre la altura de la imagen):

| Elemento | Valor objetivo |
| --- | --- |
| Espacio sobre el pelo | 12–15 % |
| Línea de los ojos | 38–42 % |
| Altura de la cabeza (pelo → mentón) | 55–60 % |
| Hombros | visibles, el borde inferior del cuadro corta a la altura del pecho |

Es el encuadre que produce un avatar limpio en LinkedIn y en el círculo de 3 cm del CV, sin
tocar nada después.

### Checklist antes de salir

- [ ] Camisa de un solo color, planchada, **botón superior cerrado**
- [ ] Barba de 3–4 mm con borde definido (o afeitado limpio, si a las 3 semanas no hay densidad)
- [ ] Ventana a 45°, sin flash, sin aro
- [ ] Fondo a 2 m, sin horizonte visible
- [ ] Cámara a la altura de los ojos, 85 mm, trípode
- [ ] Hombros girados 20–30°, barbilla adelante y abajo
- [ ] Media sonrisa de boca cerrada que llegue a los ojos, mirada a cámara
- [ ] 10 fotos como mínimo: con y sin camisa, con y sin barba

## Si aun así se quiere la vía generativa (IA de imagen)

Se puede pedir a un modelo generativo "saco" o "corte nuevo", pero hay dos advertencias:

1. **Reescribe la cara.** Estos modelos no cambian solo el pelo o la ropa: reconstruyen ojos,
  nariz y boca con pequeñas variaciones. En una foto de perfil, esa diferencia la notan las
  personas que te conocen, y en una entrevista en video es un problema. El requisito de
   respetar el rostro, por tanto, descarta esta vía para el pelo y la ropa.
2. **El fondo no lo mejora.** Un fondo generado por IA es reconocible como fondo generado por
   IA, y eso envejece mal.

Si se decide probar, el prompt que menos resultados raros da es explícito sobre qué NO tocar:

```
Retoque fotográfico mínimo de esta foto de perfil profesional. Mantener exactamente
la cara: mismo contorno de la mandíbula, mismos ojos, mismo color de piel, misma
expresión. Solo [sustituir el peinado por uno corto con raya lateral / añadir una
camisa azul claro]. Fondo liso gris neutro degradado. Iluminación suave a 45° desde
la izquierda. Formato cuadrado, la cabeza ocupando el 58 % de la altura.
```

Y luego hay que revisar el resultado a 200 %: los ojos y la línea de la mandíbula son donde se
nota la reconstrucción.

## Por qué el CV no lleva foto en la variante ATS

`style.cls` no carga `graphicx` en la rama ATS: texto seleccionable, una columna, cero
gráficos. Eso es deliberado — muchos ATS descartan o enredan los CV con imágenes. La foto
solo aparece en la variante con diseño, que es la que se manda a un reclutador que la abre en
pantalla.
