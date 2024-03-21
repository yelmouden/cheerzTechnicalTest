# Technical Test

## Architecture

The project is configured by using modular architecture with swift package manager.

There are two types of module:
  - **Domain modules:** Each domain module is responsible for managing a coherent set of features to a specific aspect of the application.
  - **Core modules:** Core modules contained all of the functionality that would be shared between the different features.   

Domain modules are isolated domains and they can't communicate each other.
Core modules can be used by modules and can use other core modules.

### Diagram
<img width="872" alt="Screenshot 2024-03-21 at 15 36 24" src="https://github.com/yelmouden/cheerzTechnicalTest/assets/2960273/f827a72d-af51-400f-9379-f87f16913544">

### Domain modules
- **Home:** Contains a screen which displays the last 30 photos from unsplash in a grid
- **Search:** Allows the user to search photos. The results are paginated
- **Detals:** Contains a screen which displays the photo details

Domains modules contains view made using SwiftUI and coupled with view models

### Core modules
- **Networking:** Allows to make network requests
- **Localizable:** Contains all the localized string. Use of String Catalogs
- **DesignSystem:** Contains the app design system like Colors and reused components
- **SharedModels:** Contains all the models shared through the app
- **AppLogger:** Allows to log activity in the app, Use OSLog as default
- **Utils:**: Contains helper/extensions methods
- **UnitTestsUtils:**: Contains helper/extensions methods used in unit tests
- **AppConfiguration:**: Contains method and value for the app configuration

## Unit Tests

Each domain module contains unit tests. There are unit tests testing the view model and other unit tests testing the views through screenshots.
Some of core domains contains also unit tests

Unit tests can be launched on each target or through the main app target that can lauch all the unit tests (Domains and Core)

The main app target contains also unit tests. The unit tests corresponds to UI tests which ensures that the flows are well executed 

## Navigation

The navigation is managed by using coordinators. 
As writted before, the domains don't know each others. When a module need to display an other module, this should be done through the main app which knows all domains of the app.

 ## Toolings

the app uses swiftlint which allows to enforce Swift style and conventions
It also uses swiftgen to generates assets. 

 ## App


https://github.com/yelmouden/cheerzTechnicalTest/assets/2960273/8e7a10ac-61ad-4507-bbd6-810beec4e2c4

