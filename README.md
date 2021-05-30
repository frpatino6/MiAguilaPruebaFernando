# MiAguilaPruebaFernando
Aplicacion movil que muestra la traza de un teléfono dependiendo su posición (Latitud Longitud)

Para iniciar la traza, se debe dar click en el botón que se encuentra en la parte inferior derecha.
En ese momento, se comienza a capturar la traza del teléfono.

Para detener se debe dar click en el mismo botón.

Para el desarrollo del proyecto, se utilizo el plugin google_maps_flutter, el cual provee el widget del mapa.
Se activo el sdk de los mapas desde la consola de google (https://console.cloud.google.com/)
Para la lectura de las posiciones del teléfono, se utilizó el plugin GeoLocator() El cual se encarga de escuchar los cambios en las posiciones, de pintar cada una de las ubicaciones por donde va pasando el dispositivo.

Se agregó un controlador para el manejo del estado de la aplicación. Para esto se utilizó GETX.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
