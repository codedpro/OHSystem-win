![Logo](http://ohsystem.net/storage/img/new_logo.jpg)
#OpenHosting

OpenHosting is a major modification of the official GHost++ source.

---

######We spent a lot of time writing this code, so show some respect:
 - Do not remove this copyright notice anywhere (bot, website etc.)
 - We do not provide support to those who removed copyright notice

OHSystem is free software: You can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

---

###### Status:
[![Build Status](https://travis-ci.org/OHSystem/OHSystem.svg?branch=master)](https://travis-ci.org/OHSystem/OHSystem)
[![Build Status](https://drone.io/github.com/OHSystem/ohsystem/status.png)](https://drone.io/github.com/OHSystem/ohsystem/latest)
[![Project Status](http://stillmaintained.com/OHSystem/ohsystem.png)](http://stillmaintained.com/OHSystem/ohsystem)

###### Consider a donation to support us and keep up our work, we sometimes need a cup of :coffee:
[![ScreenShot](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ARP4DEP4E429Y)

---
### Install guide for the bot

 - [UNIX](https://github.com/OHSystem/ohsystem/wiki/Installation---UNIX)
 - [Windows](https://github.com/OHSystem/ohsystem/wiki/Installation-WinOS)

We do not support OS X

---

### Visual Features:
- ####Live games
  - Show current games via Ajax and join them directly

  - View current running games live and keep track of them with the help of a fancy ajax refresh

  - Manage settings via remote control

  - Or simple chat with friends or players on in the current game

---

- ####Statistical recording:
  - Optimized update statistics which does not overload the server

  - Be able to compare yourself with other people
    Everything is sortable, including countries!

  - Detailed statistics of each players for the current month (and previous)

---

- ####Easy manage and control able:
  - Simple control of ban list, with lots of options and fitters
  
  - Easy setup role

  - Manage different types of games, where they will each generate separated statistics

  - We support multiply layers and templates to offer a complete hosting system

  - Review the entire game log, including lobby:

  - For users who are not administrators, and who have the ban option there is a special Moderator panel
  
  - Easily check for abusive usage by review the admin log
    
---

### Backend Features:
  - Full integration of temporary bans
  - Full integration of autobans, individual for leaving and disconnecting
  - Full integration for IPRange bans, Country Bans and Hostname bans
  - Full integration for broadcasting games to other platforms, WC3Connect or Garena
  - Detailed parsing for dota statistics
  - Full fixed balance system
  - Multiple options to handle join events and restriction
  - Integration of virtual lobbies to inform users before kicking them
  - Message system, contact people from all over the Realms
  - and a lot more featurs.

----

##### The OHSystem was founded by Neubivljiv & Grief-Code.
We have been working on the development process since over a year now and started the last months to include a full hosting platform which is constantly growing each day.

## Building ghost.exe with Docker

To cross-compile the Windows binary on macOS or Linux you can use the included `Dockerfile`. Build the image and mount a host directory to extract the result:

```bash
docker build -t ghost-builder .
mkdir out
docker run --rm -v "$(pwd)/out":/dist ghost-builder
```

The compiled `ghost.exe` will be placed inside the `out` directory on your host.

