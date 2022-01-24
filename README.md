# Aplicación de ejemplo con API de Marvel: HeroesMVVM

La app esta realizada con SwiftUI y Combine. Tiene CoreData para guardar los personajes en local.

Aplicación sencilla para la visualización de personajes de Marvel y el detalle de los mismos. En este readme podrás ver toda la información de este proyecto como:
- [Arquitectura](#arquitectura)
- [Librerías utilizadas](#librerías-utilizadas)
- [Principales características](#principales-caracteristicas)


## Arquitectura
Aplicacion realizada con **MVVM**, clean architecture, y teniendo en cuenta los diferentes principios SOLID.

Organización del proyecto:
- **Views** : Contiene las vistas en SwiftUI y los ViewModel.
- **Model** : Contiene el modelo de datos de la aplicación.
- **Common** : 
  - *Database* implementacion de CoreData. Contiene la implementación mock para los test.
  - *Views*: Vistas utilizadas en la aplicación en general.
  - *Extensions*: Extensiones de clases.
  - *Networking*: Implementación de la API. Contiene la implementacion mock para los test. Se ha utilizado combine para utilizar programación reactiva.
  - *Cells*: Celdas generales utilizadas en toda la app.


## Librerías utilizadas
- No se han utilizado librerías de terceros, solamente SwiftUI, CoreData y Combine.

## Principales caracteristicas
- Se realiza inyección de dependencias para creación de los ViewModel, permitiendo inyectar el API como DB mockeado para los test.
