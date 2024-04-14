# PRoot Apps

PRoot Apps is a simple platform to install and use applications without any privileges in Linux userspace using [PRoot](https://proot-me.github.io/). Applications are bundled with their entire toolchain much like [snap](https://snapcraft.io/) or [Flatpak](https://flatpak.org/), unlike these platforms:

* No system requirements outside of curl and bash
* Can be run in very restrictive environments even inside userspace in a Docker container
* Performs no space saving optimizations, every PRoot app lives in its own individual file folder without a base or any overlay style filesystem
* Are ingested from [Docker](https://www.docker.com/) registries and can be published by anyone while being consumed by anyone

# For Users

## Install or update

```
rm -f $HOME/.local/bin/{ncat,proot-apps,proot,jq}
mkdir -p $HOME/.local/bin
curl -L https://github.com/linuxserver/proot-apps/releases/download/$(curl -sX GET "https://api.github.com/repos/linuxserver/proot-apps/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]')/proot-apps-$(uname -m).tar.gz | tar -xzf - -C $HOME/.local/bin/
export PATH="$HOME/.local/bin:$PATH"
```

**Optional add path to env**

```
echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.bashrc
```

**PRoot Apps is currently only supported on amd64 and arm64 systems**

## Uninstall

```
proot-apps remove all
rm -f $HOME/.local/bin/{ncat,proot-apps,proot,jq}
rm -Rf $HOME/proot-apps/
```

## Hello World

To install your first app [Firefox](https://www.mozilla.org/firefox/) simply execute:

```
proot-apps install firefox
```

The files for Firefox will be installed to a folder in `$HOME/proot-apps/`, Desktop and start menu shortcuts will also be created these names should not conflict with system installed packages.

These short named apps are available from the supported list below, but any app can be consumed from a Docker endpoint IE:

```
proot-apps install ghcr.io/linuxserver/proot-apps:firefox
```

To remove the application:

```
proot-apps remove firefox
```

To update the application:

```
proot-apps update firefox
```

## Supported Apps

| Name | Full Endpoint | Arch | Description |
| :----: | :----: | :----: |--- |
| anydesk | ghcr.io/linuxserver/proot-apps:anydesk | amd64 | AnyDesk ensures secure and reliable remote desktop connections for IT professionals and on-the-go individuals alike.|
| ardour | ghcr.io/linuxserver/proot-apps:ardour | amd64,arm64 | Ardour is an open source, collaborative effort of a worldwide team including musicians, programmers, and professional recording engineers.|
| audacity | ghcr.io/linuxserver/proot-apps:audacity | amd64 | Audacity is an easy-to-use, multi-track audio editor and recorder. Developed by a group of volunteers as open source.|
| beekeeperstudio | ghcr.io/linuxserver/proot-apps:beekeeperstudio | amd64,arm64 | Use Beekeeper Studio to query and manage your relational databases, like MySQL, Postgres, SQLite, and SQL Server.|
| bitwarden | ghcr.io/linuxserver/proot-apps:bitwarden | amd64 | Bitwarden is a secure and free password manager for all of your devices.|
| blender | ghcr.io/linuxserver/proot-apps:blender | amd64,arm64 | Blender is a free and open-source 3D computer graphics software toolset used for creating animated films, visual effects, art, 3D printed models, motion graphics, interactive 3D applications, virtual reality, and computer games.|
| brave | ghcr.io/linuxserver/proot-apps:brave | amd64,arm64 | Brave is a free and open-source web browser developed by Brave Software, Inc. based on the Chromium web browser. Brave is a privacy-focused browser, which automatically blocks most advertisements and website trackers in its default settings.|
| calibre | ghcr.io/linuxserver/proot-apps:calibre | amd64,arm64 | Calibre is a powerful and easy to use e-book manager. Users say it's outstanding and a must-have. It'll allow you to do nearly everything and it takes things a step beyond normal e-book software. It's also completely free and open source and great for both casual users and computer experts.|
| chrome | ghcr.io/linuxserver/proot-apps:chrome | amd64 | Chrome is the official web browser from Google, built to be fast, secure, and customizable.|
| chromium | ghcr.io/linuxserver/proot-apps:chromium | amd64,arm64 | Chromium is an open-source browser project that aims to build a safer, faster, and more stable way for all users to experience the web. |
| deluge | ghcr.io/linuxserver/proot-apps:deluge | amd64,arm64 | Deluge is a lightweight, Free Software, cross-platform BitTorrent client.|
| digikam | ghcr.io/linuxserver/proot-apps:digikam | amd64,arm64 | Professional Photo Management with the Power of Open Source.|
| earth | ghcr.io/linuxserver/proot-apps:earth | amd64 | Google Earth Pro on desktop is free for users with advanced feature needs. Import and export GIS data, and go back in time with historical imagery.|
| filezilla | ghcr.io/linuxserver/proot-apps:filezilla | amd64,arm64 | FileZilla Client is a fast and reliable cross-platform FTP, FTPS and SFTP client with lots of useful features and an intuitive graphical user interface.|
| firefox-dev | ghcr.io/linuxserver/proot-apps:firefox-dev | amd64,arm64 | The browser made for developers, all the latest developer tools in beta in addition to features like the Multi-line Console Editor and WebSocket Inspector. A separate profile and path so you can easily run it alongside Release or Beta Firefox. Preferences tailored for web developers: Browser and remote debugging are enabled by default, as are the dark theme and developer toolbar button.|
| firefox | ghcr.io/linuxserver/proot-apps:firefox | amd64,arm64 | Firefox Browser, also known as Mozilla Firefox or simply Firefox, is a free and open-source web browser developed by the Mozilla Foundation and its subsidiary, the Mozilla Corporation. Firefox uses the Gecko layout engine to render web pages, which implements current and anticipated web standards.|
| freetube | ghcr.io/linuxserver/proot-apps:freetube | amd64,arm64 | FreeTube is an open source desktop YouTube player built with privacy in mind.|
| gimp | ghcr.io/linuxserver/proot-apps:gimp | amd64,arm64 | GIMP is a free and open-source raster graphics editor used for image manipulation (retouching) and image editing, free-form drawing, transcoding between different image file formats, and more specialized tasks. It is extensible by means of plugins, and scriptable.|
| handbrake | ghcr.io/linuxserver/proot-apps:handbrake | amd64,arm64 | HandBrake is an open-source, GPL-licensed, multiplatform, multithreaded video transcoder.|
| inkscape | ghcr.io/linuxserver/proot-apps:inkscape | amd64,arm64 | Inkscape is professional quality vector graphics software which runs on Linux, Mac OS X and Windows desktop computers.|
| kdenlive | ghcr.io/linuxserver/proot-apps:kdenlive | amd64,arm64 | Kdenlive is a powerful free and open source cross-platform video editing program made by the KDE community. Feature rich and production ready.|
| keepassxc | ghcr.io/linuxserver/proot-apps:keepassxc | amd64,arm64 | KeePassXC is a modern, secure, and open-source password manager that stores and manages your most sensitive information.|
| kicad | ghcr.io/linuxserver/proot-apps:kicad | amd64,arm64 | KiCad - A Cross Platform and Open Source Electronics Design Automation Suite.|
| kodi | ghcr.io/linuxserver/proot-apps:kodi | amd64,arm64 | Kodi spawned from the love of media. It is media center and entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customisable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community. |
| krita | ghcr.io/linuxserver/proot-apps:krita | amd64,arm64 | Krita is a professional FREE and open source painting program. It is made by artists that want to see affordable art tools for everyone.|
| libreoffice | ghcr.io/linuxserver/proot-apps:libreoffice | amd64,arm64 | LibreOffice is a free and powerful office suite, and a successor to OpenOffice.org (commonly known as OpenOffice). Its clean interface and feature-rich tools help you unleash your creativity and enhance your productivity.|
| librewolf | ghcr.io/linuxserver/proot-apps:librewolf | amd64,arm64 | This project is an independent fork of Firefox, with the primary goals of privacy security and user freedom. It is the community run successor to LibreFox.|
| moonlight | ghcr.io/linuxserver/proot-apps:moonlight | amd64,arm64 | Moonlight allows you to play your PC games on almost any device, whether you're in another room or miles away from your gaming rig.|
| nextcloud | ghcr.io/linuxserver/proot-apps:nextcloud | amd64 | The Nextcloud desktop client keeps photos and documents always up to date, enabling you to work like you always did.|
| obs | ghcr.io/linuxserver/proot-apps:obs | amd64,arm64 | OBS Studio is a free and open-source, cross-platform screencasting and streaming app.|
| obsidian | ghcr.io/linuxserver/proot-apps:obsidian | amd64 | Obsidian is a note-taking app that lets you create, link, and organize your notes on your device, with hundreds of plugins and themes to customize your workflow.|
| onlyoffice | ghcr.io/linuxserver/proot-apps:onlyoffice | amd64 | Create, view and edit documents of any size and complexity. Work with most popular formats: DOCX, ODT, XLSX, ODS, CSV, PPTX, ODP, etc. Deal with multiple files within one and the same window thanks to the tab-based user interface.|
| opera | ghcr.io/linuxserver/proot-apps:opera | amd64 | Opera is a multi-platform web browser developed by its namesake company Opera. The browser is based on Chromium, but distinguishes itself from other Chromium-based browsers (Chrome, Edge, etc.) through its user interface and other features.|
| parsec | ghcr.io/linuxserver/proot-apps:parsec | amd64 | Parsec is a remote desktop you'll actually love. Connect to work, games, or projects wherever you are, whenever you want.|
| postman | ghcr.io/linuxserver/proot-apps:postman | amd64,arm64 | Postman is an application that allows the testing of web APIs.|
| qbittorrent | ghcr.io/linuxserver/proot-apps:qbittorrent | amd64,arm64 | The Qbittorrent project aims to provide an open-source software alternative to µTorrent. qBittorrent is based on the Qt toolkit and libtorrent-rasterbar library.|
| remmina | ghcr.io/linuxserver/proot-apps:remmina | amd64,arm64 | Remmina is a remote desktop client written in GTK, aiming to be useful for system administrators and travellers, who need to work with lots of remote computers in front of either large or tiny screens. Remmina supports multiple network protocols, in an integrated and consistent user interface.|
| retroarch | ghcr.io/linuxserver/proot-apps:retroarch | amd64,arm64 | RetroArch is a free and open-source, cross-platform frontend for emulators, game engines, video games, media players and other applications.|
| shortwave | ghcr.io/linuxserver/proot-apps:shortwave | amd64,arm64 | Shortwave is an internet radio player that provides access to a station database with over 30,000 stations. |
| shotcut | ghcr.io/linuxserver/proot-apps:shotcut | amd64,arm64 | Shotcut is a free, open source, cross-platform video editor.|
| sqlitebrowser | ghcr.io/linuxserver/proot-apps:sqlitebrowser | amd64,arm64 | DB Browser for SQLite is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite.|
| thunderbird | ghcr.io/linuxserver/proot-apps:thunderbird | amd64,arm64 | Thunderbird is free and open-source email client software which also functions as a full personal information manager with a calendar and contactbook, as well as an RSS feed reader, chat client (IRC/XMPP/Matrix), and news client.|
| telegram | ghcr.io/linuxserver/proot-apps:telegram | amd64,arm64 | Telegram is a cloud-based mobile and desktop messaging app with a focus on security and speed.|
| torbrowser | ghcr.io/linuxserver/proot-apps:torbrowser | amd64 | Tor is free and open-source software for enabling anonymous communication by directing Internet traffic through a free, worldwide, volunteer overlay network.|
| vivaldi | ghcr.io/linuxserver/proot-apps:vivaldi | amd64,arm64 | Vivaldi is a freeware, cross-platform web browser with a built-in email client developed by Vivaldi Technologies.|
| vlc | ghcr.io/linuxserver/proot-apps:vlc | amd64,arm64 | VLC media player (previously the VideoLAN Client and commonly known as simply VLC) is a free and open-source, portable, cross-platform media player software and streaming media server developed by the VideoLAN project.|
| vscode | ghcr.io/linuxserver/proot-apps:vscode | amd64,arm64 | Visual Studio Code is a source-code editor developed by Microsoft for Windows, Linux and macOS|
| vscodium | ghcr.io/linuxserver/proot-apps:vscodium | amd64,arm64 | VSCodium is a community-driven, freely-licensed binary distribution of Microsoft’s editor VS Code.|
| webcord | ghcr.io/linuxserver/proot-apps:webcord | amd64,arm64 | WebCord can be summarized as a pack of security and privacy hardenings, Discord features reimplementations, Electron / Chromium / Discord bugs workarounds, stylesheets, internal pages and wrapped https://discord.com page, designed to conform with ToS as much as it is possible (or hide the changes that might violate it from Discord's eyes).|
| yandex | ghcr.io/linuxserver/proot-apps:yandex | amd64 | Yandex Browser is a freeware web browser developed by the Russian technology corporation Yandex that uses the Blink web browser.|
| zoom | ghcr.io/linuxserver/proot-apps:zoom | amd64 | Zoom is a proprietary videotelephony software program developed by Zoom Video Communications.|

# For Developers

This repository was made to be cloned and forked with all of the build logic being templated to the repository owner and name. Simply forking this repository and enabling GitHub actions should be enough to get building using GitHub's builders. Also included in this repository is a nightly package check action, in order to use that you will need to set a [GitHub Secret](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) for `PAT` for that bot to work as it needs basic write access to the repo to trigger downstream build actions. The build logic is currently configured to detect changes to the specific folders in `apps` to determine if they need to be built. To build a backlog of the images in this repo when forked removing the package_versions.txt from the apps you want to build and commiting that is likely the easiest approach. `find . -name package_versions.txt -exec git rm {} \;`

When forking all readme updates should be made to the `ci-scripts/README.template` as this is the source file used to write out the readme linked to your forked repo.

## Building local apps

Prerequisites:

* [Docker](https://www.docker.com/) installed
* PRoot apps installed as your user

In this repository is a helper script `build-install-local` that can be used to generate a PRoot app from the build logic in this repo. To build and extract the firefox image simply: 

```
./build-install-local firefox
```

Then follow the instructions to install and test it out.

## Basic application structure

We are using Docker to do the heavy lifting here, leveraging it for building and it's registry system for hosting the applications. In the end what makes up a PRoot app is the entire operating system needed for the application to run. There are 4 files required for an application:

* Dockerfile - This contains all of the build logic for the application, installation and customization for the application should be performed here including:
  - Desktop file launching proot-apps instead of the default command from OS install
  - Setting a bin name for the application so it can be launched from the users CLI
  - Modifying the Name of the application in it's desktop entry as to not conflict with the users OS level applications
* entrypoint - This file is executed every time the application is launched it should contain any logic for the application to run properly, this might include custom flags to drop sandboxing requirements as they will not work in PRoot
* install - This file will be called when the user installs the application with proot-apps it should:
  - Add a desktop shortcut if applicable
  - Add a start menu entry if applicable
  - Add an icon for the application if applicable
* remove - This file will be called when the user uninstalls the application with proot-apps it should:
  - Remove a desktop shortcut if applicable
  - Remove a start menu entry if applicable
  - Remove an icon for the application if applicable

It is important to understand that nothing about this platform is security focused PRoot in general is running in userspace and can easily be escaped by the application by simply killing its Tracer PID. The point of this platform is not application isolation it is easing the burden of installation to not require any form of sudo access or unconventional platform binaries. To that end on init PRoot Apps will also start a system socket for sending commands to the underlying host to escape it's jail. This leverages a UNIX socket with ncat to relay commands to the host. This is required to open things like file explorers on the host that would otherwise not be available. PRoot already mounts in the system dbus socket and many applications will leverage this to call external programs in Desktop userspace, for applications that do not use this they will conventionally pass URLs and file paths to `xdg-open`. The `xdg-open` binary in the PRoot jail can be replaced with a simple wrapper: 

```
#!/bin/bash
echo "xdg-open "$@"" | nc -N -U /system.socket
```

This same wrapper concept can be used to wrap any other binary inside the jail that you would want to open up on the host and not inside of the PRoot runspace itself.

One other concept to keep in mind is if you want it to work in the application you will need to install it in the build logic. The only storage space PRoot really has access to at runtime is the user's home directory. If the program needs GPU acceleration, you will need to install the drivers (amdgpu, dri gallium, etc). If the program needs language packs or fonts again you will need to install them. In general this approach is incredibly wasteful when it comes to disk space but without using more complex systems like OverlayFS or bubblewrap (user namespacing) it is necessary.
