# Locavid
An app that lets you see the routes infected people have taken so that you can protect from the virus better.

## Running Instructions

Welcome.dart is the entry point.

<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

* [Flutter](https://flutter.dev/docs/get-started/install)
* [Android Studio](https://developer.android.com/studio?hl=nl)

### Installation

1. Get a free Google API Key at [Google APIs](https://console.developers.google.com/)
2. Enable Maps SDK for Android or iOS depends on your desired platform
3. Enable Directions API as well
4. Clone the repo
```sh
git clone https://github.com/E2Slayer/Locavid.git
```
5. Execute the command to get dependancies
```sh
flutter pub get
```
6. Follow the instruction for setting up Google Maps API
[Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)

7. Put your Google API key in libs/Mainpage.dart and worldmap.dart
```dart
GoogleMapPolyline googleMapPolyline =new GoogleMapPolyline(apiKey: "YOUR_KEY_HERE");
```
## About

Made by [@e2slayer](https://e2slayer.github.io/), [@etasbasi](http://etasbasi.com), and [@shixiaoqing](https://github.com/shixiaoqing) with 💚 and Flutter.

