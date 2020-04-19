<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/E2Slayer/Locavid">
    <img src="images/small_logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Locavid</h3>

  <p align="center">
    Share your Path, Save Lives
    <br />
    <a href="https://github.com/E2Slayer/Locavid"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/E2Slayer/Locavid">View Demo</a>
    ·
    <a href="https://github.com/E2Slayer/Locavid/issues">Report Bug</a>
    ·
    <a href="hhttps://github.com/E2Slayer/Locavid/issues">Request Feature</a>
  </p>
</p>

<!-- ABOUT THE PROJECT -->
## About The Project

  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/loginpage.png" alt="Logo">
  </a>

### Inspiration
  In this day and age an infectious disease can easily spread across the world causing a pandemic. Both developing and developed countries are suffering the repercussions of COVID-19. Many people believed that Western countries were prepared for the possibility of a pandemic, but in truth they were not. Other countries like South Korea however, are effectively fighting against the spread of COVID-19. One interesting and effective strategy employed by the South Korean government is releasing past location information of confirmed patients. As shown by South Korea, this is a viable solution but many countries cannot do the same thing due to privacy concerns. Inspired by this concept, we have developed an app that will implement this idea without invading upon people’s privacy.

### What it does
  Locavid tracks the locations of users spanning back a week. It enables the users to view paths taken by people that have since tested positive for COVID-19 or other contagious viruses. Should users test positive they are able to share the paths that they have taken with their friends and family, and with the user’s permission they can anonymously share their data and contribute to the global map for the general social good. Most importantly, Locavid can help users avoid potential COVID-19 hotzones as well as helping their friends and other users avoid them as well, thus lowering the infection rate. 


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

