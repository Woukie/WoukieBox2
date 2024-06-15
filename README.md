# WoukieBox2
WoukieBox but much better.

Check it out [here](https://box.woukie.net/)

## Features
- Group-chat and dm history is saved!
- Add friends
- Create group chats and dms with other users
- Authentication
- Profile customisation
- App customisation
- Deployed to both web and windows
- Desktop notifications and notification customisation
- Can use the global room without an account!

## Roadmap
- Further notification system improvements
- Various bug fixes
- Message timestamps
- Further group changes + improvements (icons, leave/join messages, kicking/promoting users)
- WebRTC voice calls
- idk

## Get Started
- You will need the serverpod and flutter cli tools
- Clone the repo
- run pub get
- In the server:
  - Create config files (same as in serverpod setup, if deploying production, will also need to add gmail credentials)
  - Run `docker compose up --build --detach` to start the postgres and redis databases
  - Run `dart bin/main.dart` to start the serverpod server
  - May need to run `dart bin/main.dart --role maintenance --apply-migrations` if you have issues connecting to database
- In the flutter application run `flutter run` and choose to build for windows
