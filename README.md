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

### Graphical Installer

Supported applications can be installed via a graphical installer by adding it:

```
proot-apps install gui
```

### Command Line

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

<details>
  <summary>Click to expand</summary>

| Name | Full Endpoint | Arch | Description |
| :----: | :----: | :----: |--- |
| anydesk | ghcr.io/linuxserver/proot-apps:anydesk | linux/amd64 | AnyDesk ensures secure and reliable remote desktop connections for IT professionals and on-the-go individuals alike.|
| ardour | ghcr.io/linuxserver/proot-apps:ardour | linux/amd64,linux/arm64 | Ardour is an open source, collaborative effort of a worldwide team including musicians, programmers, and professional recording engineers.|
| audacity | ghcr.io/linuxserver/proot-apps:audacity | linux/amd64 | Audacity is an easy-to-use, multi-track audio editor and recorder. Developed by a group of volunteers as open source.|
| beekeeperstudio | ghcr.io/linuxserver/proot-apps:beekeeperstudio | linux/amd64,linux/arm64 | Use Beekeeper Studio to query and manage your relational databases, like MySQL, Postgres, SQLite, and SQL Server.|
| bitwarden | ghcr.io/linuxserver/proot-apps:bitwarden | linux/amd64 | Bitwarden is a secure and free password manager for all of your devices.|
| blender | ghcr.io/linuxserver/proot-apps:blender | linux/amd64,linux/arm64 | Blender is a free and open-source 3D computer graphics software toolset used for creating animated films, visual effects, art, 3D printed models, motion graphics, interactive 3D applications, virtual reality, and computer games.|
| brave | ghcr.io/linuxserver/proot-apps:brave | linux/amd64,linux/arm64 | Brave is a free and open-source web browser developed by Brave Software, Inc. based on the Chromium web browser. Brave is a privacy-focused browser, which automatically blocks most advertisements and website trackers in its default settings.|
| calibre | ghcr.io/linuxserver/proot-apps:calibre | linux/amd64,linux/arm64 | Calibre is a powerful and easy to use e-book manager. Users say it's outstanding and a must-have. It'll allow you to do nearly everything and it takes things a step beyond normal e-book software. It's also completely free and open source and great for both casual users and computer experts.|
| chrome | ghcr.io/linuxserver/proot-apps:chrome | linux/amd64 | Chrome is the official web browser from Google, built to be fast, secure, and customizable.|
| chromium | ghcr.io/linuxserver/proot-apps:chromium | linux/amd64,linux/arm64 | Chromium is an open-source browser project that aims to build a safer, faster, and more stable way for all users to experience the web.|
| deluge | ghcr.io/linuxserver/proot-apps:deluge | linux/amd64,linux/arm64 | Deluge is a lightweight, Free Software, cross-platform BitTorrent client.|
| digikam | ghcr.io/linuxserver/proot-apps:digikam | linux/amd64,linux/arm64 | Professional Photo Management with the Power of Open Source.|
| dolphin | ghcr.io/linuxserver/proot-apps:dolphin | linux/amd64,linux/arm64 | Dolphin is an emulator for two recent Nintendo video game consoles: the GameCube and the Wii. It allows PC gamers to enjoy games for these two consoles in full HD (1080p) with several enhancements: compatibility with all PC controllers, turbo speed, networked multiplayer, and even more.|
| doublecmd | ghcr.io/linuxserver/proot-apps:doublecmd | linux/amd64,linux/arm64 | Double Commander is a free cross-platform open source file manager with two panels side by side (or one above the other). It is inspired by Total Commander and features some innovative new ideas.|
| earth | ghcr.io/linuxserver/proot-apps:earth | linux/amd64 | Google Earth Pro on desktop is free for users with advanced feature needs. Import and export GIS data, and go back in time with historical imagery.|
| eclipsejava | ghcr.io/linuxserver/proot-apps:eclipsejava | linux/amd64,linux/arm64 | Eclipse IDE, the essential tools for any Java developer, including a Java IDE, a Git client, XML Editor, Maven and Gradle integration.|
| filezilla | ghcr.io/linuxserver/proot-apps:filezilla | linux/amd64,linux/arm64 | FileZilla Client is a fast and reliable cross-platform FTP, FTPS and SFTP client with lots of useful features and an intuitive graphical user interface.|
| firefox | ghcr.io/linuxserver/proot-apps:firefox | linux/amd64,linux/arm64 | Firefox Browser, also known as Mozilla Firefox or simply Firefox, is a free and open-source web browser developed by the Mozilla Foundation and its subsidiary, the Mozilla Corporation. Firefox uses the Gecko layout engine to render web pages, which implements current and anticipated web standards.|
| firefox-dev | ghcr.io/linuxserver/proot-apps:firefox-dev | linux/amd64,linux/arm64 | The browser made for developers, all the latest developer tools in beta in addition to features like the Multi-line Console Editor and WebSocket Inspector. A separate profile and path so you can easily run it alongside Release or Beta Firefox. Preferences tailored for web developers: Browser and remote debugging are enabled by default, as are the dark theme and developer toolbar button.|
| flameshot | ghcr.io/linuxserver/proot-apps:flameshot | linux/amd64,linux/arm64 | Flameshot is a free and open-source, cross-platform tool to take screenshots with many built-in features to save you time.|
| flycast | ghcr.io/linuxserver/proot-apps:flycast | linux/amd64 | Flycast is a multi-platform Sega Dreamcast, Naomi, Naomi 2, and Atomiswave emulator derived from reicast.|
| freetube | ghcr.io/linuxserver/proot-apps:freetube | linux/amd64,linux/arm64 | FreeTube is an open source desktop YouTube player built with privacy in mind.|
| gimp | ghcr.io/linuxserver/proot-apps:gimp | linux/amd64,linux/arm64 | GIMP is a free and open-source raster graphics editor used for image manipulation (retouching) and image editing, free-form drawing, transcoding between different image file formats, and more specialized tasks. It is extensible by means of plugins, and scriptable.|
| handbrake | ghcr.io/linuxserver/proot-apps:handbrake | linux/amd64,linux/arm64 | HandBrake is an open-source, GPL-licensed, multiplatform, multithreaded video transcoder.|
| idea | ghcr.io/linuxserver/proot-apps:idea | linux/amd64,linux/arm64 | IntelliJ IDEA Community Edition is an Integrated Development Environment (IDE) for Java and Kotlin designed to maximize developer productivity.|
| inkscape | ghcr.io/linuxserver/proot-apps:inkscape | linux/amd64,linux/arm64 | Inkscape is professional quality vector graphics software which runs on Linux, Mac OS X and Windows desktop computers.|
| kdenlive | ghcr.io/linuxserver/proot-apps:kdenlive | linux/amd64,linux/arm64 | Kdenlive is a powerful free and open source cross-platform video editing program made by the KDE community. Feature rich and production ready.|
| keepassxc | ghcr.io/linuxserver/proot-apps:keepassxc | linux/amd64,linux/arm64 | KeePassXC is a modern, secure, and open-source password manager that stores and manages your most sensitive information.|
| kicad | ghcr.io/linuxserver/proot-apps:kicad | linux/amd64,linux/arm64 | KiCad - A Cross Platform and Open Source Electronics Design Automation Suite.|
| kodi | ghcr.io/linuxserver/proot-apps:kodi | linux/amd64,linux/arm64 | Kodi spawned from the love of media. It is media center and entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customisable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community.|
| krita | ghcr.io/linuxserver/proot-apps:krita | linux/amd64,linux/arm64 | Krita is a professional FREE and open source painting program. It is made by artists that want to see affordable art tools for everyone.|
| ktorrent | ghcr.io/linuxserver/proot-apps:ktorrent | linux/amd64,linux/arm64 | KTorrent is a BitTorrent application by KDE which allows you to download files using the BitTorrent protocol.|
| libreoffice | ghcr.io/linuxserver/proot-apps:libreoffice | linux/amd64,linux/arm64 | LibreOffice is a free and powerful office suite, and a successor to OpenOffice.org (commonly known as OpenOffice). Its clean interface and feature-rich tools help you unleash your creativity and enhance your productivity.|
| librewolf | ghcr.io/linuxserver/proot-apps:librewolf | linux/amd64,linux/arm64 | This project is an independent fork of Firefox, with the primary goals of privacy security and user freedom. It is the community run successor to LibreFox.|
| lmms | ghcr.io/linuxserver/proot-apps:lmms | linux/amd64,linux/arm64 | LMMS is a free, open source, multiplatform digital audio workstation.|
| logisim | ghcr.io/linuxserver/proot-apps:logisim | linux/amd64 | Logisim-evolution is educational software for designing and simulating digital logic circuits.|
| lollypop | ghcr.io/linuxserver/proot-apps:lollypop | linux/amd64,linux/arm64 | Lollypop is a lightweight modern music player designed to work excellently on the GNOME desktop environment.|
| maltego | ghcr.io/linuxserver/proot-apps:maltego | linux/amd64,linux/arm64 | Maltego is link analysis software used for open-source intelligence, forensics and other investigations.|
| melonds | ghcr.io/linuxserver/proot-apps:melonds | linux/amd64,linux/arm64 | melonDS aims at providing fast and accurate Nintendo DS emulation.|
| moonlight | ghcr.io/linuxserver/proot-apps:moonlight | linux/amd64,linux/arm64 | Moonlight allows you to play your PC games on almost any device, whether you're in another room or miles away from your gaming rig.|
| mumble | ghcr.io/linuxserver/proot-apps:mumble | linux/amd64,linux/arm64 | Mumble is a free, open source, low latency, high quality voice chat application.|
| nextcloud | ghcr.io/linuxserver/proot-apps:nextcloud | linux/amd64 | The Nextcloud desktop client keeps photos and documents always up to date, enabling you to work like you always did.|
| obs | ghcr.io/linuxserver/proot-apps:obs | linux/amd64 | OBS Studio is a free and open-source, cross-platform screencasting and streaming app.|
| obsidian | ghcr.io/linuxserver/proot-apps:obsidian | linux/amd64 | Obsidian is a note-taking app that lets you create, link, and organize your notes on your device, with hundreds of plugins and themes to customize your workflow.|
| onlyoffice | ghcr.io/linuxserver/proot-apps:onlyoffice | linux/amd64 | Create, view and edit documents of any size and complexity. Work with most popular formats: DOCX, ODT, XLSX, ODS, CSV, PPTX, ODP, etc. Deal with multiple files within one and the same window thanks to the tab-based user interface.|
| opera | ghcr.io/linuxserver/proot-apps:opera | linux/amd64 | Opera is a multi-platform web browser developed by its namesake company Opera. The browser is based on Chromium, but distinguishes itself from other Chromium-based browsers (Chrome, Edge, etc.) through its user interface and other features.|
| parsec | ghcr.io/linuxserver/proot-apps:parsec | linux/amd64 | Parsec is a remote desktop you'll actually love. Connect to work, games, or projects wherever you are, whenever you want.|
| postman | ghcr.io/linuxserver/proot-apps:postman | linux/amd64,linux/arm64 | Postman is an application that allows the testing of web APIs.|
| ppsspp | ghcr.io/linuxserver/proot-apps:ppsspp | linux/amd64,linux/arm64 | PPSSPP is a PSP emulator that can run games in full HD resolution.|
| pycharm | ghcr.io/linuxserver/proot-apps:pycharm | linux/amd64,linux/arm64 | PyCharm Community Edition IDE is designed by programmers, for programmers, to provide all the tools you need for productive Python development.|
| qbittorrent | ghcr.io/linuxserver/proot-apps:qbittorrent | linux/amd64,linux/arm64 | The Qbittorrent project aims to provide an open-source software alternative to µTorrent. qBittorrent is based on the Qt toolkit and libtorrent-rasterbar library.|
| remmina | ghcr.io/linuxserver/proot-apps:remmina | linux/amd64,linux/arm64 | Remmina is a remote desktop client written in GTK, aiming to be useful for system administrators and travellers, who need to work with lots of remote computers in front of either large or tiny screens. Remmina supports multiple network protocols, in an integrated and consistent user interface.|
| retroarch | ghcr.io/linuxserver/proot-apps:retroarch | linux/amd64,linux/arm64 | RetroArch is a free and open-source, cross-platform frontend for emulators, game engines, video games, media players and other applications.|
| ryujinx | ghcr.io/linuxserver/proot-apps:ryujinx | linux/amd64,linux/arm64 | Ryujinx is an open-source Nintendo Switch emulator.|
| shortwave | ghcr.io/linuxserver/proot-apps:shortwave | linux/amd64,linux/arm64 | Shortwave is an internet radio player that provides access to a station database with over 30,000 stations.|
| shotcut | ghcr.io/linuxserver/proot-apps:shotcut | linux/amd64,linux/arm64 | Shotcut is a free, open source, cross-platform video editor.|
| spotube | ghcr.io/linuxserver/proot-apps:spotube | linux/amd64 | Spotube is an open source, cross-platform Spotify client compatible across multiple platforms utilizing Spotify's data API and YouTube, Piped.video or JioSaavn as an audio source, eliminating the need for Spotify Premium|
| sqlitebrowser | ghcr.io/linuxserver/proot-apps:sqlitebrowser | linux/amd64,linux/arm64 | DB Browser for SQLite is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite.|
| telegram | ghcr.io/linuxserver/proot-apps:telegram | linux/amd64,linux/arm64 | Telegram is a cloud-based mobile and desktop messaging app with a focus on security and speed.|
| thunderbird | ghcr.io/linuxserver/proot-apps:thunderbird | linux/amd64,linux/arm64 | Thunderbird is free and open-source email client software which also functions as a full personal information manager with a calendar and contactbook, as well as an RSS feed reader, chat client (IRC/XMPP/Matrix), and news client.|
| torbrowser | ghcr.io/linuxserver/proot-apps:torbrowser | linux/amd64 | Tor is free and open-source software for enabling anonymous communication by directing Internet traffic through a free, worldwide, volunteer overlay network.|
| vivaldi | ghcr.io/linuxserver/proot-apps:vivaldi | linux/amd64,linux/arm64 | Vivaldi is a freeware, cross-platform web browser with a built-in email client developed by Vivaldi Technologies.|
| vlc | ghcr.io/linuxserver/proot-apps:vlc | linux/amd64,linux/arm64 | VLC media player (previously the VideoLAN Client and commonly known as simply VLC) is a free and open-source, portable, cross-platform media player software and streaming media server developed by the VideoLAN project.|
| vscode | ghcr.io/linuxserver/proot-apps:vscode | linux/amd64,linux/arm64 | Visual Studio Code is a source-code editor developed by Microsoft for Windows, Linux and macOS|
| vscodium | ghcr.io/linuxserver/proot-apps:vscodium | linux/amd64,linux/arm64 | VSCodium is a community-driven, freely-licensed binary distribution of Microsoft’s editor VS Code.|
| weather | ghcr.io/linuxserver/proot-apps:weather | linux/amd64,linux/arm64 | A small application that allows you to monitor the current weather conditions for your city, or anywhere in the world.|
| webcord | ghcr.io/linuxserver/proot-apps:webcord | linux/amd64,linux/arm64 | WebCord can be summarized as a pack of security and privacy hardenings, Discord features reimplementations, Electron / Chromium / Discord bugs workarounds, stylesheets, internal pages and wrapped https://discord.com page, designed to conform with ToS as much as it is possible.|
| wpsoffice | ghcr.io/linuxserver/proot-apps:wpsoffice | linux/amd64 | WPS Office is a lightweight, feature-rich comprehensive office suite with high compatibility. As a handy and professional office software, WPS Office allows you to edit files in Writer, Presentation, Spreadsheet, and PDF to improve your work efficiency.|
| yandex | ghcr.io/linuxserver/proot-apps:yandex | linux/amd64 | Yandex Browser is a freeware web browser developed by the Russian technology corporation Yandex that uses the Blink web browser.|
| zoom | ghcr.io/linuxserver/proot-apps:zoom | linux/amd64 | Zoom is a proprietary videotelephony software program developed by Zoom Video Communications.|
| zotero | ghcr.io/linuxserver/proot-apps:zotero | linux/amd64 | Zotero is a free, easy-to-use tool to help you collect, organize, annotate, cite, and share research.|


</details>

# For Developers

This repository was made to be cloned and forked with all of the build logic being templated to the repository owner and name. Simply forking this repository and enabling GitHub actions should be enough to get building using GitHub's builders. Also included in this repository is a nightly package check action, in order to use that you will need to set a [GitHub Secret](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) for `PAT` for that bot to work as it needs basic write access to the repo to trigger downstream build actions. The build logic is currently configured to detect changes to the specific folders in `apps` to determine if they need to be built. To build a backlog of the images in this repo when forked removing the package_versions.txt from the apps you want to build and commiting that is likely the easiest approach. `find . -name package_versions.txt -exec git rm {} \;`

When forking all readme updates should be made to the `ci-scripts/README.template` as this is the source file used to write out the readme linked to your forked repo. Also keep in mind all the logic in your forked proot-apps binary and gui installer will be linked to your repostiry and packages.

To generate release tarballs of proot-apps to be ingested with your install command a tag needs to be generated in your fork. This can be achieved with `git tag 0.1.0 && git push origin --tags`. This again will be linked back to your repo in all references for app ingestion.

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

## Adding a new app

Three are three things needed for an app to work with all build and ingestion logic: 

* A folder with a `Dockerfile` must be created in the `/apps/` directory named after the app name (this is what the user types to install the application)
* Metadata for the application must be added to `/metadata/metadata.yml` file including:
  - name - the app name also tied to the folder used previously, should be a single string all lowercase
  - full_name - the display name for the application
  - arch - what arches to build the application for
  - icon - the icon name for the application
  - description - a blurb explaining the application to the user
  - (optional) disabled - this will only build and push the tag for the application, it will not be advertised in the readme or desktop application
* A logo for the application placed in the `/metadata/img` folder of the repository, svg is preffered here, but can also use 192x192 pngs

When adding new applications we highly encourage copying an existing application folder as a start to understand what files are needed. Most apps can simply be installed from a distribution's repository and then it is just housekeeping to ensure the desktop file and icon conform to PRoot apps standards.

# For Administrators

PRoot Apps can use a local folder for app management and updates. This essentially replaces the remote repository with a folder of tar files. This is setup by using the environment variable `PA_REPO_FOLDER`, when set the user will pull their apps from a local folder of tar files at that path instead of a remote repo including updates.

## Setup Local Repo

In this example we will use the path `/mnt/apps` to act as our local repository. First create the directory and set your env:

```
mkdir /mnt/apps
export PA_REPO_FOLDER=/mnt/apps
```

We can use the `localrepo` action to perform get, update, or remove. Update and remove support passing `all` as a string to perform the action on all locally stored apps.

Get some apps: 

```
proot-apps localrepo get firefox chrome
```

Inside this folder will be:

```
└── /mnt/apps/
    ├── ghcr.io_YOURNAMESPACE_proot-apps_chrome/
    │   ├── app.tar.gz
    │   └── SHALAYER
    └── ghcr.io_YOURNAMESPACE_proot-apps_firefox/
        ├── app.tar.gz
        └── SHALAYER
```

`localrepo` can be used to update this repo as well:

```
proot-apps localrepo update all
```

This will sync down any updates from remote. 

To have users leverage the gui app in your namespace to install and remove applications you will also need to place the metadata from your repository (metadata folder) in this directory IE: 

```
└── /mnt/apps/
    └── metadata/
        ├── metadata.yml
        └── img/
            ├── logo1.svg
            └── logo2.svg
```

The metadata can be customized to what you want to present to the user in the gui application.

## Userspace ingesting the repo

The most likely scenario would be mounting your repo into the users session read only at a specific mount point like `/mnt/apps`.

To achieve this if it is a Docker container just mount in with a bind and set the env: 

```
-e PA_REPO_FOLDER=/mnt/apps
-v /mnt/apps:/mnt/apps:ro
```

When the user uses proot-apps in this session it will all be connected into this folders contents instead of a remote repository.

On the administration side the apps can be updated in the folder and the users with this mount will be able to ingest them with the normal command:

```
proot-apps update all
```
