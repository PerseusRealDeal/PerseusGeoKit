# Approbation Matrix / PerseusGeoLocationKit 1.0.0 && 1.0.1 && 1.0.2 && 1.0.2

> NOTE: To catch all log messages Mac Console should be started first then after a little while the logged app.

> Compilation: macOS Monterey 12.7.6 / Xcode 14.2

## macOS approbation result

> The macOS app used to approbate PerseusGeoLocationKit is [Arkenstone](https://github.com/perseusrealdeal/Arkenstone).

| macOS       | Version | Result  | Details |
| ----------- | ------- | :-----: | ------- |
| High Sierra | 10.13   | ok      | Approbated accept movement simulation. |
| Mojave      | 10.14   | ok      | - |
| Catalina    | 10.15   | ok      | - |
| Big Sur     | 11.7    | ok      | - |
| Monterey    | 12.7    | ok      | - |
| Ventura     | 13.7    | ok      | - |
| Sonoma      | 14.7    | ok      | Returns LS status .notDetermed if turn LS off, OpenCore usage case. |
| Sequoia     | 15.1    | ok      | Returns LS status .notDetermed if turn LS off, OpenCore usage case. |

## iOS approbation result

> The iOS app used to approbate PerseusGeoLocationKit is [The One Ring](https://github.com/perseusrealdeal/TheOneRing).

| Device          | Simulator | OS Version | Result  | Details |
| --------------- | :-------: | ---------- | :-----: | ------- |
| iPad Air        | no        | 12.5.7     | ok      | - |
| iPhone SE (3rd) | yes       | 16.2       | ok      | Simulator generates error on every event of currentLocation/start but value received |

## A3 environment

### List of available Apple machines

> Excluded: virtualization (e.g. VirtualBox) and hackintosh

| Machine     | Memory | Storage                |
| ----------- | ------ | ---------------------- |
| Mac mini    | 16GB   | SATA 480GB, NVMe 256GB |
| MacBook Pro | 8GB    | 256GB                  |

### System configuration for A3 environment

| macOS       | Version | Machine     | Xcode  | OpenCore | Git Client     |
| ----------- | ------- | ----------- | ------ | -------- | -------------- |
| High Sierra | 10.13.6 | Mac mini    | 10.1   | -        | GitHub Desktop |
| Mojave      | 10.14.6 | Mac mini    | 11.3.1 | -        | GitHub Desktop |
| Catalina    | 10.15.7 | Mac mini    | 11.7   | -        | GitHub Desktop |
| Big Sur     | 11.7.10 | Mac mini    | 13.2.1 | -        | GitHub Desktop |
| Monterey    | 12.7.6  | Mac mini    | 14.2   | -        | SmartGit       |
| Ventura     | 13.7.4  | MacBook Pro | 15.2   | -        | GitHub Desktop |
| Sonoma      | 14.7.4  | MacBook Pro | 16.2   | yes      | GitHub Desktop |
| Sequoia     | 15.3.1  | MacBook Pro | 16.2   | yes      | GitHub Desktop |
