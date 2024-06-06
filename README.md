# WoukieBox2
WoukieBox but much better.

Check it out [here](https://box.woukie.net/)

## Features
- One single global chatroom
- Authentication
- Profile customisation
- App Themes
- Desktop app
- Anonymous connection
- Web app
- Notification customisation

## Get Started
- Clone the repo
- run pub get
- In the server:
  - Create config files (follow serverpod setup)
  - Run `docker compose up --build --detach` to start the postgres and redis databases
  - Run `dart bin/main.dart` to start the serverpod server
  - May need to run `dart bin/main.dart --role maintenance --apply-migrations` if you have issues connecting to database
- In the flutter application run `flutter run` and choose to build for windows
