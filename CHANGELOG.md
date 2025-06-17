# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).<br/>

Dates in this file meets Gregorian calendar. Date in format YYYY-MM-DD.

## [1.0.2] - [2025-06-17], PGK

### Upgraded

- PerseusLogger to [CPL v1.5.0](https://github.com/perseusrealdeal/ConsolePerseusLogger).

## [1.0.1] - [2025-05-31], PGK

### Fixed

- iOS: Location Services permission request if status in .notDetermined.

## [1.0.0] - [2025-05-31], PGK

- Minimum build requirements: macOS 10.13+, iOS 11.0+, Xcode 14.2+. If standalone Xcode 10.1+.

### Changed

- Project structure, classes and catologs names are changed.

### Added

- Approbation and Changelog.
- The Redirect Dialog (ActionAlert) with redirecting to System Settings for both iOS and macOS.

### Improved

- Source Code (renamed, cleared, restructured, logged).
- Documentation.

### Upgraded

- PerseusLogger to [CPL v1.3.0](https://github.com/perseusrealdeal/ConsolePerseusLogger).

### Corrected

- OpenCore Usage Case: macOS returns LS status .notDetermed if turn LS off, reinit location manager.

### Removed

- Unit tests, import test only.

## [0.1.0] - [2023-07-24], Developer Release

- Minimum build requirements: macOS 10.9+, iOS 9.3+, and Xcode 10.1+.

### Added

- Requesting Current location with a result represented as PerseusLocation class.
- Requesting Location Changing updates.
- Requesting Location Service Status change with a result represented as LocationPermit.
- Error notifications represented as LocationError enum.
- Custom Location Permission represented as LocationPermit enum.

## [0.0.1] - [2023-02-27], Developer Beginning Release

### Added

- Initial point of development process of [The Technological Tree](https://github.com/perseusrealdeal/TheTechnologicalTree).
