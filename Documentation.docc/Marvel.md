# ``Marvel``

An app to use the https://developer.marvel.com API to grab data of comics, characters, etc.

## Overview

This app only shows one view to the user. Where they can search for a comic book specified by an ID.

![Marvel App](marvel-app.png)

Other frameworks that were used:
- Alamofire: Used to make the network requests.
- Swinject: Dependency injection.

## Topics

### Essentials

- <doc:GettingStarted>
- ``MarvelApp``

### Dependency Injection

- ``MarvelAssembly``
- ``MarvelResolver``

### Views

- ``ContentView``
- ``ComicSearchView``
- ``ComicView``
- ``SettingsView``

### ViewModels

- ``ComicViewModel``
- ``Settings``
- ``SettingsViewModel``

### DataSources

- ``DataSource``
- ``MarvelDataSource``

### Services

- ``MarvelAPIService``

### Models

- ``ResponseContainer``
- ``DataContainer``
- ``MarvelModel``
- ``ComicModel``
- ``MImage``

### Utils

- ``SessionContainer``
- ``SessionContainerProvider``
- ``MockSessionContainer``
