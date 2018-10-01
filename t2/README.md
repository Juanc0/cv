# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo; y,
2. Sombrear su superficie a partir de los colores de sus vértices.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Opcionales:

1. Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas; y,
2. Sombrear su superficie mediante su [mapa de profundidad](https://en.wikipedia.org/wiki/Depth_map).

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [frames](https://github.com/VisualComputing/frames/releases).

## Integrantes

Dos, o máximo tres si van a realizar al menos un opcional.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|Andres Gonzalez Ortiz|Anvido|
|Juan Pablo Ovalle Sánchez|Juanc0|


## Discusión

### Rasterización y sombreado

Se impolementó el triangle raster teniendo en cuenta las referencias propuestas, se asignó un color a cada vector, se calcularon las coordenadas baricentricas y con base a estas se asignó el peso de los canales RGB para cada uno de los pixeles que cuenten con el centro dentro de la primitiva. Al momento de calcular las funciones de borde, fue importante definir el orden de los vectores del triangulo para permitir un recorrido antihorario de la primitiva.

### Anti-Aliasing

En el algoritmo de anti-aliasing se tuvo en cuenta la referncia propuesta [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) de la cual escogimos implementar el método basado en muestreo (porcentaje de subpixeles que se encuentran dentro de la primitiva). En el programa se agregó un evento de teclado con la letra 'a' qué permite alternar entre el uso de esta técnica.

## Entrega

* Modo de entrega: [Fork](https://help.github.com/articles/fork-a-repo/) la plantilla en las cuentas de los integrantes.
* Plazo: 30/9/18 a las 24h.
