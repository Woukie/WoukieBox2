# WoukieBox2
WoukieBox but with flutter

## Features
- One single global chatroom
- Authentication
- Profile customisation
- App Themes
- Desktop app
- Anonymous connection

## Get Started
- Clone the repo
- run pub get
- In the server:
  - Run `docker compose up --build --detach` to start the postgres and redis databases
  - Run `dart bin/main.dart` to start the serverpod server
- In the flutter application run `flutter run` and choose to build for windows
