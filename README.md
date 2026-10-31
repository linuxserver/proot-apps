# PRoot Apps

PRoot Apps is a simple platform to install and use applications without any privileges in Linux userspace using [proot-next](https://github.com/selkies-project/proot-next), a Rust reimplementation of [PRoot](https://proot-me.github.io/). Applications are bundled with their entire toolchain much like [snap](https://snapcraft.io/) or [Flatpak](https://flatpak.org/), unlike these platforms:

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

**Optional add path to env and enable bash completion**

```
echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.bashrc
echo 'command -v proot-apps >/dev/null && source <(proot-apps completion bash)' >> $HOME/.bashrc
```

**Optional enable bwrap support**

The bundled proot binary also acts as an unprivileged [bubblewrap](https://github.com/containers/bubblewrap) when it is called as `bwrap` via a symlink.

```
ln -sf proot $HOME/.local/bin/bwrap
```

**PRoot Apps is currently only supported on amd64 and arm64 systems**

## Uninstall

```
proot-apps remove all
rm -f $HOME/.local/bin/{ncat,proot-apps,proot,jq}
[ "$(readlink $HOME/.local/bin/bwrap)" == "proot" ] && rm -f $HOME/.local/bin/bwrap
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

| Name | Full Endpoint | Category | Arch | Description |
| :----: | :----: | :----: | :----: |--- |
| 86box | ghcr.io/linuxserver/proot-apps:86box | Game | linux/amd64 | 86Box is a low level x86 emulator that runs older operating systems and software designed for IBM PC systems and compatibles from 1981 through the mid 2000s. The official rom set is bundled with the image.|
| affine | ghcr.io/linuxserver/proot-apps:affine | Office | linux/amd64 | AFFiNE is a local first knowledge base that combines documents, whiteboards and databases in one workspace. Write, draw and plan in the same place and optionally sync across devices.|
| antigravity | ghcr.io/linuxserver/proot-apps:antigravity | AI | linux/amd64,linux/arm64 | Antigravity is an agent first IDE from Google based on VS Code with autonomous coding agents and Gemini built in.|
| anydesk | ghcr.io/linuxserver/proot-apps:anydesk | Network | linux/amd64 | AnyDesk ensures secure and reliable remote desktop connections for IT professionals and on-the-go individuals alike.|
| anytype | ghcr.io/linuxserver/proot-apps:anytype | Office | linux/amd64 | Anytype is a local first app for notes, documents and databases built from reusable objects and relations. Your data is encrypted on device and can sync peer to peer across devices.|
| appflowy | ghcr.io/linuxserver/proot-apps:appflowy | Office | linux/amd64 | AppFlowy is an open source notes and project management workspace with documents, databases, boards and calendars that works offline and syncs when you want it to.|
| ardour | ghcr.io/linuxserver/proot-apps:ardour | AudioVideo | linux/amd64,linux/arm64 | Ardour is an open source, collaborative effort of a worldwide team including musicians, programmers, and professional recording engineers.|
| audacity | ghcr.io/linuxserver/proot-apps:audacity | AudioVideo | linux/amd64 | Audacity is an easy-to-use, multi-track audio editor and recorder. Developed by a group of volunteers as open source.|
| aws-workspaces | ghcr.io/linuxserver/proot-apps:aws-workspaces | Network | linux/amd64 | AWS WorkSpaces client for connecting to Amazon WorkSpaces virtual desktops.|
| azahar | ghcr.io/linuxserver/proot-apps:azahar | Game | linux/amd64 | Azahar is an open-source Nintendo 3DS emulator based on Citra, focused on accuracy, performance and ease of use.|
| beekeeperstudio | ghcr.io/linuxserver/proot-apps:beekeeperstudio | Development | linux/amd64 | Use Beekeeper Studio to query and manage your relational databases, like MySQL, Postgres, SQLite, and SQL Server.|
| bimcraft | ghcr.io/linuxserver/proot-apps:bimcraft | Creative | linux/amd64 | BIMCraft is an open source building information modeling app written in Rust in the spirit of Revit that models walls, floors, roofs, rooms, sheets and schedules and opens and saves IFC files.|
| bitwarden | ghcr.io/linuxserver/proot-apps:bitwarden | Utility | linux/amd64 | Bitwarden is a secure and free password manager for all of your devices.|
| blender | ghcr.io/linuxserver/proot-apps:blender | Creative | linux/amd64 | Blender is a free and open-source 3D computer graphics software toolset used for creating animated films, visual effects, art, 3D printed models, motion graphics, interactive 3D applications, virtual reality, and computer games.|
| blockbench | ghcr.io/linuxserver/proot-apps:blockbench | Creative | linux/amd64 | Blockbench is a low poly 3D model editor for creating, texturing and animating models. It supports Minecraft formats and exports to glTF, OBJ and other common formats.|
| brave | ghcr.io/linuxserver/proot-apps:brave | Network | linux/amd64,linux/arm64 | Brave is a free and open-source web browser developed by Brave Software, Inc. based on the Chromium web browser. Brave is a privacy-focused browser, which automatically blocks most advertisements and website trackers in its default settings.|
| braveorigin | ghcr.io/linuxserver/proot-apps:braveorigin | Network | linux/amd64,linux/arm64 | Brave Origin is a minimalist version of Brave that allows users to disable the revenue-generating features that otherwise support Brave as a business.|
| bruno | ghcr.io/linuxserver/proot-apps:bruno | Development | linux/amd64 | Bruno is an open source API client for exploring and testing APIs. It stores collections as plain files on disk so they can be versioned with git.|
| cadcraft | ghcr.io/linuxserver/proot-apps:cadcraft | Creative | linux/amd64,linux/arm64 | CADCraft is an open source 2D computer aided design and drafting app from ArtCraft with layers, dimensions, hatches and blocks that opens and saves DXF and DWG drawings.|
| calibre | ghcr.io/linuxserver/proot-apps:calibre | Office | linux/amd64,linux/arm64 | Calibre is a powerful and easy to use e-book manager. Users say it's outstanding and a must-have. It'll allow you to do nearly everything and it takes things a step beyond normal e-book software. It's also completely free and open source and great for both casual users and computer experts.|
| celluloid | ghcr.io/linuxserver/proot-apps:celluloid | AudioVideo | linux/amd64,linux/arm64 | Celluloid is a simple GTK+ frontend for mpv. It aims to be easy to use while maintaining high level of configurability.|
| cemu | ghcr.io/linuxserver/proot-apps:cemu | Game | linux/amd64 | Cemu is a Wii U emulator that is able to run most Wii U games and homebrew in a playable state.|
| chatgpt | ghcr.io/linuxserver/proot-apps:chatgpt | AI | linux/amd64,linux/arm64 | ChatGPT is the desktop app from OpenAI which includes Codex for running agentic coding tasks on your local projects.|
| chrome | ghcr.io/linuxserver/proot-apps:chrome | Network | linux/amd64 | Chrome is the official web browser from Google, built to be fast, secure, and customizable.|
| chromium | ghcr.io/linuxserver/proot-apps:chromium | Network | linux/amd64,linux/arm64 | Chromium is an open-source browser project that aims to build a safer, faster, and more stable way for all users to experience the web.|
| claude | ghcr.io/linuxserver/proot-apps:claude | AI | linux/amd64,linux/arm64 | Claude is the desktop app from Anthropic with chat and Claude Code for agentic coding with parallel sessions, visual diff review and an integrated terminal.|
| cryptomator | ghcr.io/linuxserver/proot-apps:cryptomator | Utility | linux/amd64 | Cryptomator creates encrypted vaults for files stored in cloud services such as Dropbox, Google Drive and OneDrive so that only you can read them.|
| cursor | ghcr.io/linuxserver/proot-apps:cursor | AI | linux/amd64 | Cursor is an AI code editor based on VS Code with agent driven editing, codebase aware chat and tab completion built in. It is a proprietary editor that needs an account to use the AI features.|
| deckcraft | ghcr.io/linuxserver/proot-apps:deckcraft | Office | linux/amd64,linux/arm64 | DeckCraft is an open source presentation app from ArtCraft with themes, layouts, charts, transitions and a presenter view that opens and saves PPTX files.|
| deluge | ghcr.io/linuxserver/proot-apps:deluge | Network | linux/amd64,linux/arm64 | Deluge is a lightweight, Free Software, cross-platform BitTorrent client.|
| designcraft | ghcr.io/linuxserver/proot-apps:designcraft | Creative | linux/amd64,linux/arm64 | DesignCraft is an open source page layout and publishing app from ArtCraft rebuilt in pure Rust for documents, brochures and print design.|
| digikam | ghcr.io/linuxserver/proot-apps:digikam | Creative | linux/amd64,linux/arm64 | Professional Photo Management with the Power of Open Source.|
| dolphin | ghcr.io/linuxserver/proot-apps:dolphin | Game | linux/amd64 | Dolphin is an emulator for two recent Nintendo video game consoles: the GameCube and the Wii. It allows PC gamers to enjoy games for these two consoles in full HD (1080p) with several enhancements: compatibility with all PC controllers, turbo speed, networked multiplayer, and even more.|
| dosbox | ghcr.io/linuxserver/proot-apps:dosbox | Game | linux/amd64 | DOSBox Staging is a modern continuation of DOSBox with advanced features and improvements for running DOS games and software.|
| doublecmd | ghcr.io/linuxserver/proot-apps:doublecmd | System | linux/amd64,linux/arm64 | Double Commander is a free cross-platform open source file manager with two panels side by side (or one above the other). It is inspired by Total Commander and features some innovative new ideas.|
| drawio | ghcr.io/linuxserver/proot-apps:drawio | Office | linux/amd64 | draw.io is a desktop diagramming application for flowcharts, network diagrams, UML, mockups and more. It works fully offline and saves diagrams as editable files.|
| dreamm | ghcr.io/linuxserver/proot-apps:dreamm | Game | linux/amd64,linux/arm64 | DREAMM is a bespoke emulator for LucasArts games, relying on low-level emulation instead of reverse engineering.|
| duckstation | ghcr.io/linuxserver/proot-apps:duckstation | Game | linux/amd64 | DuckStation is a simulator/emulator of the Sony PlayStation console, focusing on playability, speed, and long-term maintainability.|
| earth | ghcr.io/linuxserver/proot-apps:earth | Science | linux/amd64 | Google Earth Pro on desktop is free for users with advanced feature needs. Import and export GIS data, and go back in time with historical imagery.|
| eclipsejava | ghcr.io/linuxserver/proot-apps:eclipsejava | Development | linux/amd64,linux/arm64 | Eclipse IDE, the essential tools for any Java developer, including a Java IDE, a Git client, XML Editor, Maven and Gradle integration.|
| eden | ghcr.io/linuxserver/proot-apps:eden | Game | linux/amd64 | Eden is an experimental open-source emulator for the Nintendo Switch, built with performance and stability in mind.|
| edge | ghcr.io/linuxserver/proot-apps:edge | Network | linux/amd64 | Microsoft Edge is a cross-platform web browser developed by Microsoft and based on Chromium.|
| effectcraft | ghcr.io/linuxserver/proot-apps:effectcraft | AudioVideo | linux/amd64,linux/arm64 | EffectCraft is an open source motion graphics and visual effects compositor from ArtCraft built in pure Rust.|
| feishin | ghcr.io/linuxserver/proot-apps:feishin | AudioVideo | linux/amd64 | Feishin is a modern music client for self hosted Navidrome and Jellyfin servers. It offers playlists, smart queues and gapless playback through the MPV or web audio backends.|
| ferdium | ghcr.io/linuxserver/proot-apps:ferdium | Network | linux/amd64,linux/arm64 | Ferdium is a desktop app that helps you organize how you use your favourite apps by combining them into one application.|
| figcraft | ghcr.io/linuxserver/proot-apps:figcraft | Creative | linux/amd64,linux/arm64 | FigCraft is an open source interface design and prototyping app from ArtCraft with frames, vector shapes and text on an infinite canvas, auto layout, components, variants and interactive prototypes.|
| filezilla | ghcr.io/linuxserver/proot-apps:filezilla | Network | linux/amd64,linux/arm64 | FileZilla Client is a fast and reliable cross-platform FTP, FTPS and SFTP client with lots of useful features and an intuitive graphical user interface.|
| filmcraft | ghcr.io/linuxserver/proot-apps:filmcraft | AudioVideo | linux/amd64,linux/arm64 | FilmCraft is an open source video editor from ArtCraft rebuilt from scratch in Rust with a timeline, clips, transitions and GPU accelerated playback.|
| firefox | ghcr.io/linuxserver/proot-apps:firefox | Network | linux/amd64,linux/arm64 | Firefox Browser, also known as Mozilla Firefox or simply Firefox, is a free and open-source web browser developed by the Mozilla Foundation and its subsidiary, the Mozilla Corporation. Firefox uses the Gecko layout engine to render web pages, which implements current and anticipated web standards.|
| firefox-dev | ghcr.io/linuxserver/proot-apps:firefox-dev | Network | linux/amd64,linux/arm64 | The browser made for developers, all the latest developer tools in beta in addition to features like the Multi-line Console Editor and WebSocket Inspector. A separate profile and path so you can easily run it alongside Release or Beta Firefox. Preferences tailored for web developers: Browser and remote debugging are enabled by default, as are the dark theme and developer toolbar button.|
| flameshot | ghcr.io/linuxserver/proot-apps:flameshot | Utility | linux/amd64,linux/arm64 | Flameshot is a free and open-source, cross-platform tool to take screenshots with many built-in features to save you time.|
| floorp | ghcr.io/linuxserver/proot-apps:floorp | Network | linux/amd64 | Floorp is a Firefox based web browser developed in Japan with a focus on privacy, customization and flexibility. It adds features such as workspaces, a sidebar panel and extensive layout options.|
| flycast | ghcr.io/linuxserver/proot-apps:flycast | Game | linux/amd64 | Flycast is a multi-platform Sega Dreamcast, Naomi, Naomi 2, and Atomiswave emulator derived from reicast.|
| freecad | ghcr.io/linuxserver/proot-apps:freecad | Creative | linux/amd64,linux/arm64 | FreeCAD is an open-source parametric 3D modeler made primarily to design real-life objects of any size.|
| freeciv | ghcr.io/linuxserver/proot-apps:freeciv | Game | linux/amd64,linux/arm64 | Freeciv is a Free and Open Source empire-building strategy game inspired by the history of human civilization.|
| freedoom | ghcr.io/linuxserver/proot-apps:freedoom | Game | linux/amd64,linux/arm64 | The Freedoom project aims to produce three base-game data files (IWADs) for Doom-compatible engines. With it comes the capability to also play the wide range of mods created for Doom by a vibrant community.|
| geany | ghcr.io/linuxserver/proot-apps:geany | Development | linux/amd64,linux/arm64 | Geany is a powerful, stable and lightweight programmers text editor.|
| ghostty | ghcr.io/linuxserver/proot-apps:ghostty | System | linux/amd64 | Ghostty is a fast, feature rich and native terminal emulator built with GTK4 and libadwaita.|
| gimp | ghcr.io/linuxserver/proot-apps:gimp | Creative | linux/amd64,linux/arm64 | GIMP is a free and open-source raster graphics editor used for image manipulation (retouching) and image editing, free-form drawing, transcoding between different image file formats, and more specialized tasks. It is extensible by means of plugins, and scriptable.|
| godot | ghcr.io/linuxserver/proot-apps:godot | Development | linux/amd64,linux/arm64 | Godot Engine is a free and open source, feature-packed, cross-platform game engine to create 2D and 3D games from a unified interface.|
| gridcraft | ghcr.io/linuxserver/proot-apps:gridcraft | Office | linux/amd64,linux/arm64 | GridCraft is an open source native spreadsheet from ArtCraft that opens and saves XLSX workbooks and CSV files with hundreds of worksheet functions, sorting, filtering and charts.|
| handbrake | ghcr.io/linuxserver/proot-apps:handbrake | AudioVideo | linux/amd64,linux/arm64 | HandBrake is an open-source, GPL-licensed, multiplatform, multithreaded video transcoder.|
| hatchzip | ghcr.io/linuxserver/proot-apps:hatchzip | Utility | linux/amd64 | HatchZip is an open source archive extractor written in Rust that unpacks zip, 7z, rar, tar and other archives in place so only the extracted files need free disk space.|
| helium | ghcr.io/linuxserver/proot-apps:helium | Network | linux/amd64,linux/arm64 | Helium is a Chromium-based web browser made for people, with love. Privacy-first with unbiased ad-blocking.|
| idea | ghcr.io/linuxserver/proot-apps:idea | Development | linux/amd64,linux/arm64 | IntelliJ IDEA Community Edition is an Integrated Development Environment (IDE) for Java and Kotlin designed to maximize developer productivity.|
| ingetrazo | ghcr.io/linuxserver/proot-apps:ingetrazo | Creative | linux/amd64 | IngeTrazo is a free SketchUp style push pull 3D modeler for architecture and civil engineering that opens skp and collada files and exports to common CAD formats.|
| inkscape | ghcr.io/linuxserver/proot-apps:inkscape | Creative | linux/amd64,linux/arm64 | Inkscape is professional quality vector graphics software which runs on Linux, Mac OS X and Windows desktop computers.|
| jan | ghcr.io/linuxserver/proot-apps:jan | AI | linux/amd64 | Jan is an open source chat app that runs large language models locally on your own hardware and can also connect to remote providers.|
| joplin | ghcr.io/linuxserver/proot-apps:joplin | Utility | linux/amd64 | Joplin is a free, open source note taking and to-do application, which can handle a large number of notes organised into notebooks.|
| kdenlive | ghcr.io/linuxserver/proot-apps:kdenlive | AudioVideo | linux/amd64 | Kdenlive is a powerful free and open source cross-platform video editing program made by the KDE community. Feature rich and production ready.|
| keepassxc | ghcr.io/linuxserver/proot-apps:keepassxc | Utility | linux/amd64,linux/arm64 | KeePassXC is a modern, secure, and open-source password manager that stores and manages your most sensitive information.|
| kicad | ghcr.io/linuxserver/proot-apps:kicad | Creative | linux/amd64,linux/arm64 | KiCad - A Cross Platform and Open Source Electronics Design Automation Suite.|
| kodi | ghcr.io/linuxserver/proot-apps:kodi | AudioVideo | linux/amd64,linux/arm64 | Kodi spawned from the love of media. It is media center and entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customisable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community.|
| krita | ghcr.io/linuxserver/proot-apps:krita | Creative | linux/amd64 | Krita is a professional FREE and open source painting program. It is made by artists that want to see affordable art tools for everyone.|
| ktorrent | ghcr.io/linuxserver/proot-apps:ktorrent | Network | linux/amd64,linux/arm64 | KTorrent is a BitTorrent application by KDE which allows you to download files using the BitTorrent protocol.|
| libreoffice | ghcr.io/linuxserver/proot-apps:libreoffice | Office | linux/amd64,linux/arm64 | LibreOffice is a free and powerful office suite, and a successor to OpenOffice.org (commonly known as OpenOffice). Its clean interface and feature-rich tools help you unleash your creativity and enhance your productivity.|
| librewolf | ghcr.io/linuxserver/proot-apps:librewolf | Network | linux/amd64,linux/arm64 | This project is an independent fork of Firefox, with the primary goals of privacy security and user freedom. It is the community run successor to LibreFox.|
| lightcraft | ghcr.io/linuxserver/proot-apps:lightcraft | Creative | linux/amd64,linux/arm64 | LightCraft is an open source photo library and raw developer from ArtCraft that catalogs, culls and develops your photos locally.|
| lmms | ghcr.io/linuxserver/proot-apps:lmms | AudioVideo | linux/amd64,linux/arm64 | LMMS is a free, open source, multiplatform digital audio workstation.|
| lmstudio | ghcr.io/linuxserver/proot-apps:lmstudio | AI | linux/amd64 | LM Studio is a desktop app for discovering, downloading and running local LLMs with a chat interface and an OpenAI compatible local server.|
| logisim | ghcr.io/linuxserver/proot-apps:logisim | Education | linux/amd64 | Logisim-evolution is educational software for designing and simulating digital logic circuits.|
| logseq | ghcr.io/linuxserver/proot-apps:logseq | Office | linux/amd64 | Logseq is a privacy first outliner for note taking and knowledge management. Notes live in plain markdown or org mode files with bidirectional links, graphs and journals.|
| lollypop | ghcr.io/linuxserver/proot-apps:lollypop | AudioVideo | linux/amd64,linux/arm64 | Lollypop is a lightweight modern music player designed to work excellently on the GNOME desktop environment.|
| losslesscut | ghcr.io/linuxserver/proot-apps:losslesscut | AudioVideo | linux/amd64 | LosslessCut trims, cuts and merges video and audio files without re encoding so edits are fast and keep the original quality. It also extracts streams and remuxes between containers using ffmpeg.|
| maltego | ghcr.io/linuxserver/proot-apps:maltego | Utility | linux/amd64,linux/arm64 | Maltego is link analysis software used for open-source intelligence, forensics and other investigations.|
| mame | ghcr.io/linuxserver/proot-apps:mame | Game | linux/amd64 | MAME is a multi-purpose emulation framework whose purpose is to preserve decades of arcade and computer software history.|
| mayo | ghcr.io/linuxserver/proot-apps:mayo | Creative | linux/amd64,linux/arm64 | Mayo is an open-source 3D CAD viewer and converter based on Open CASCADE Technology and Qt.|
| melonds | ghcr.io/linuxserver/proot-apps:melonds | Game | linux/amd64,linux/arm64 | melonDS aims at providing fast and accurate Nintendo DS emulation.|
| moonlight | ghcr.io/linuxserver/proot-apps:moonlight | Game | linux/amd64,linux/arm64 | Moonlight allows you to play your PC games on almost any device, whether you're in another room or miles away from your gaming rig.|
| mumble | ghcr.io/linuxserver/proot-apps:mumble | Network | linux/amd64,linux/arm64 | Mumble is a free, open source, low latency, high quality voice chat application.|
| nextcloud | ghcr.io/linuxserver/proot-apps:nextcloud | Network | linux/amd64 | The Nextcloud desktop client keeps photos and documents always up to date, enabling you to work like you always did.|
| obs | ghcr.io/linuxserver/proot-apps:obs | AudioVideo | linux/amd64 | OBS Studio is a free and open-source, cross-platform screencasting and streaming app.|
| obsidian | ghcr.io/linuxserver/proot-apps:obsidian | Utility | linux/amd64 | Obsidian is a note-taking app that lets you create, link, and organize your notes on your device, with hundreds of plugins and themes to customize your workflow.|
| onlyoffice | ghcr.io/linuxserver/proot-apps:onlyoffice | Office | linux/amd64 | Create, view and edit documents of any size and complexity. Work with most popular formats: DOCX, ODT, XLSX, ODS, CSV, PPTX, ODP, etc. Deal with multiple files within one and the same window thanks to the tab-based user interface.|
| opencloud | ghcr.io/linuxserver/proot-apps:opencloud | Network | linux/amd64 | The OpenCloud Desktop Client enables file synchronization between a local computer and OpenCloud.|
| opencode | ghcr.io/linuxserver/proot-apps:opencode | AI | linux/amd64 | OpenCode is an open source AI coding agent and the desktop app provides a native GUI with sessions, diffs and terminal access to your projects.|
| opera | ghcr.io/linuxserver/proot-apps:opera | Network | linux/amd64 | Opera is a multi-platform web browser developed by its namesake company Opera. The browser is based on Chromium, but distinguishes itself from other Chromium-based browsers (Chrome, Edge, etc.) through its user interface and other features.|
| orcaslicer | ghcr.io/linuxserver/proot-apps:orcaslicer | Creative | linux/amd64 | OrcaSlicer is an open source Next-Gen Slicing Software for Precision 3D Prints.|
| parsec | ghcr.io/linuxserver/proot-apps:parsec | Game | linux/amd64 | Parsec is a remote desktop you'll actually love. Connect to work, games, or projects wherever you are, whenever you want.|
| pcsx2 | ghcr.io/linuxserver/proot-apps:pcsx2 | Game | linux/amd64 | PCSX2 is a free and open-source PlayStation 2 emulator that supports a wide range of games with high compatibility.|
| pdfcraft | ghcr.io/linuxserver/proot-apps:pdfcraft | Office | linux/amd64,linux/arm64 | PdfCraft is an open source PDF workbench from ArtCraft for reading, organizing, combining, splitting and securing PDF files.|
| photocraft | ghcr.io/linuxserver/proot-apps:photocraft | Creative | linux/amd64,linux/arm64 | PhotoCraft is an open source native image editor from ArtCraft with layers, masks, adjustment layers, brushes and type that opens and saves layered PSD and PSB files.|
| pixelorama | ghcr.io/linuxserver/proot-apps:pixelorama | Creative | linux/amd64 | Pixelorama is a free and open source pixel art editor built with Godot that supports animation, layers, palettes, custom brushes and export to sprite sheets.|
| postman | ghcr.io/linuxserver/proot-apps:postman | Development | linux/amd64,linux/arm64 | Postman is an application that allows the testing of web APIs.|
| ppsspp | ghcr.io/linuxserver/proot-apps:ppsspp | Game | linux/amd64,linux/arm64 | PPSSPP is a PSP emulator that can run games in full HD resolution.|
| pycharm | ghcr.io/linuxserver/proot-apps:pycharm | Development | linux/amd64,linux/arm64 | PyCharm Community Edition IDE is designed by programmers, for programmers, to provide all the tools you need for productive Python development.|
| qbittorrent | ghcr.io/linuxserver/proot-apps:qbittorrent | Network | linux/amd64,linux/arm64 | The Qbittorrent project aims to provide an open-source software alternative to µTorrent. qBittorrent is based on the Qt toolkit and libtorrent-rasterbar library.|
| remmina | ghcr.io/linuxserver/proot-apps:remmina | Network | linux/amd64,linux/arm64 | Remmina is a remote desktop client written in GTK, aiming to be useful for system administrators and travellers, who need to work with lots of remote computers in front of either large or tiny screens. Remmina supports multiple network protocols, in an integrated and consistent user interface.|
| retroarch | ghcr.io/linuxserver/proot-apps:retroarch | Game | linux/amd64,linux/arm64 | RetroArch is a free and open-source, cross-platform frontend for emulators, game engines, video games, media players and other applications.|
| rpcs3 | ghcr.io/linuxserver/proot-apps:rpcs3 | Game | linux/amd64 | RPCS3 is an experimental open-source Sony PlayStation 3 emulator and debugger written in C++.|
| ruffle | ghcr.io/linuxserver/proot-apps:ruffle | Game | linux/amd64 | Ruffle is a Flash Player emulator written in Rust that plays SWF games and animations on modern systems without the original plugin.|
| rustdesk | ghcr.io/linuxserver/proot-apps:rustdesk | Network | linux/amd64,linux/arm64 | RustDesk is a remote access and remote control software, primarily written in Rust, that enables remote maintenance of computers and other devices.|
| rustgis | ghcr.io/linuxserver/proot-apps:rustgis | Science | linux/amd64 | RustGIS is an open source desktop GIS from the opengeos project written in Rust in the spirit of QGIS that loads vector and raster layers, styles them and runs spatial analysis on GeoJSON, shapefile and GeoTIFF data.|
| scummvm | ghcr.io/linuxserver/proot-apps:scummvm | Game | linux/amd64 | ScummVM allows you to run certain classic graphical adventure and role-playing games, provided you already have their data files.|
| shortwave | ghcr.io/linuxserver/proot-apps:shortwave | AudioVideo | linux/amd64,linux/arm64 | Shortwave is an internet radio player that provides access to a station database with over 30,000 stations.|
| shotcut | ghcr.io/linuxserver/proot-apps:shotcut | AudioVideo | linux/amd64,linux/arm64 | Shotcut is a free, open source, cross-platform video editor.|
| solidcraft | ghcr.io/linuxserver/proot-apps:solidcraft | Creative | linux/amd64,linux/arm64 | SolidCraft is an open source parametric 3D CAD application built in Rust with a constraint based sketcher, a parametric feature timeline, components, joints and sheet metal that opens and saves STEP, IGES, 3MF, STL and OBJ files.|
| soundcraft | ghcr.io/linuxserver/proot-apps:soundcraft | AudioVideo | linux/amd64,linux/arm64 | SoundCraft is an open source native digital audio workstation from ArtCraft for recording, editing and mixing multitrack audio and MIDI.|
| spotify | ghcr.io/linuxserver/proot-apps:spotify | AudioVideo | linux/amd64 | Spotify is a digital music service that gives you access to millions of songs. YOU MUST LOGIN WITH QR CODE!|
| spotube | ghcr.io/linuxserver/proot-apps:spotube | AudioVideo | linux/amd64 | Spotube is an open source, cross-platform Spotify client compatible across multiple platforms utilizing Spotify's data API and YouTube, Piped.video or JioSaavn as an audio source, eliminating the need for Spotify Premium|
| sqlitebrowser | ghcr.io/linuxserver/proot-apps:sqlitebrowser | Development | linux/amd64,linux/arm64 | DB Browser for SQLite is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite.|
| steam | ghcr.io/linuxserver/proot-apps:steam | Game | linux/amd64 | Steam is the game store and launcher from Valve, installed into your home directory and run natively in its own Steam Runtime container.|
| stremio | ghcr.io/linuxserver/proot-apps:stremio | AudioVideo | linux/amd64 | Stremio offers a secure, modern and seamless entertainment experience. With its easy-to-use interface and diverse content library, including 4K HDR support, users can enjoy their favorite movies and TV shows across all their devices.|
| tabby | ghcr.io/linuxserver/proot-apps:tabby | System | linux/amd64,linux/arm64 | Tabby is an infinitely customizable cross-platform terminal app for local shells, serial, SSH and Telnet connections.|
| teams | ghcr.io/linuxserver/proot-apps:teams | Network | linux/amd64 | Teams for Linux is an unofficial Microsoft Teams client built with Electron. It wraps the Teams web app as a standalone desktop application with notifications and tray support.|
| telegram | ghcr.io/linuxserver/proot-apps:telegram | Network | linux/amd64 | Telegram is a cloud-based mobile and desktop messaging app with a focus on security and speed.|
| thunderbird | ghcr.io/linuxserver/proot-apps:thunderbird | Office | linux/amd64,linux/arm64 | Thunderbird is free and open-source email client software which also functions as a full personal information manager with a calendar and contactbook, as well as an RSS feed reader, chat client (IRC/XMPP/Matrix), and news client.|
| torbrowser | ghcr.io/linuxserver/proot-apps:torbrowser | Network | linux/amd64 | Tor is free and open-source software for enabling anonymous communication by directing Internet traffic through a free, worldwide, volunteer overlay network.|
| tracedraw | ghcr.io/linuxserver/proot-apps:tracedraw | Creative | linux/amd64 | TraceDraw is an open source vector illustration and page layout app written in Rust in the spirit of CorelDRAW with shapes, curves, text, effects and multi page documents that opens CDR files.|
| ungoogledchromium | ghcr.io/linuxserver/proot-apps:ungoogledchromium | Network | linux/amd64 | Google Chromium, sans integration with Google.|
| vectorcraft | ghcr.io/linuxserver/proot-apps:vectorcraft | Creative | linux/amd64,linux/arm64 | VectorCraft is a fast open source vector illustration app from ArtCraft written in pure Rust with paths, shapes, text and layers.|
| vesktop | ghcr.io/linuxserver/proot-apps:vesktop | Network | linux/amd64 | Vesktop is a custom Discord desktop client with Vencord built in. It adds plugins, themes and better screen sharing on Linux.|
| vita3k | ghcr.io/linuxserver/proot-apps:vita3k | Game | linux/amd64 | Vita3K is an experimental open source PlayStation Vita emulator. It runs commercial and homebrew Vita titles using a Vulkan or OpenGL renderer.|
| vivaldi | ghcr.io/linuxserver/proot-apps:vivaldi | Network | linux/amd64,linux/arm64 | Vivaldi is a freeware, cross-platform web browser with a built-in email client developed by Vivaldi Technologies.|
| vlc | ghcr.io/linuxserver/proot-apps:vlc | AudioVideo | linux/amd64,linux/arm64 | VLC media player (previously the VideoLAN Client and commonly known as simply VLC) is a free and open-source, portable, cross-platform media player software and streaming media server developed by the VideoLAN project.|
| vscode | ghcr.io/linuxserver/proot-apps:vscode | Development | linux/amd64,linux/arm64 | Visual Studio Code is a source-code editor developed by Microsoft for Windows, Linux and macOS|
| vscodium | ghcr.io/linuxserver/proot-apps:vscodium | Development | linux/amd64,linux/arm64 | VSCodium is a community-driven, freely-licensed binary distribution of Microsoft’s editor VS Code.|
| warp | ghcr.io/linuxserver/proot-apps:warp | System | linux/amd64 | Warp is a modern terminal written in Rust with AI assistance, block based output and collaboration features.|
| weather | ghcr.io/linuxserver/proot-apps:weather | Utility | linux/amd64,linux/arm64 | A small application that allows you to monitor the current weather conditions for your city, or anywhere in the world.|
| webcord | ghcr.io/linuxserver/proot-apps:webcord | Network | linux/amd64,linux/arm64 | WebCord can be summarized as a pack of security and privacy hardenings, Discord features reimplementations, Electron / Chromium / Discord bugs workarounds, stylesheets, internal pages and wrapped https://discord.com page, designed to conform with ToS as much as it is possible.|
| wechat | ghcr.io/linuxserver/proot-apps:wechat | Network | linux/amd64 | WeChat or Weixin in Chinese is an instant messaging, social media, and mobile payment app developed by Tencent.|
| winegui | ghcr.io/linuxserver/proot-apps:winegui | Utility | linux/amd64 | A user-interface friendly Wine (A compatibility layer capable of running Windows applications under Linux) Manager.|
| wordcraft | ghcr.io/linuxserver/proot-apps:wordcraft | Office | linux/amd64,linux/arm64 | WordCraft is an open source word processor from ArtCraft with styles, tables, track changes and mail merge that opens and saves DOCX, PDF, ODT, RTF, HTML and Markdown files.|
| wpsoffice | ghcr.io/linuxserver/proot-apps:wpsoffice | Office | linux/amd64 | WPS Office is a lightweight, feature-rich comprehensive office suite with high compatibility. As a handy and professional office software, WPS Office allows you to edit files in Writer, Presentation, Spreadsheet, and PDF to improve your work efficiency.|
| xemu | ghcr.io/linuxserver/proot-apps:xemu | Game | linux/amd64 | xemu is a low-level, full-system emulator for the original Xbox game console.|
| xenia | ghcr.io/linuxserver/proot-apps:xenia | Game | linux/amd64 | Xenia Edge is a fork of the Xenia Xbox 360 research emulator with additional fixes and enhancements.|
| yaak | ghcr.io/linuxserver/proot-apps:yaak | Development | linux/amd64 | Yaak is a desktop API client for interacting with REST, GraphQL, WebSocket, SSE and gRPC services.|
| yandex | ghcr.io/linuxserver/proot-apps:yandex | Network | linux/amd64 | Yandex Browser is a freeware web browser developed by the Russian technology corporation Yandex that uses the Blink web browser.|
| youtubemusic | ghcr.io/linuxserver/proot-apps:youtubemusic | AudioVideo | linux/amd64 | YouTube Music is a desktop wrapper for the YouTube Music web player with a plugin system. It adds ad blocking, downloads, Discord presence and many other optional features.|
| zed | ghcr.io/linuxserver/proot-apps:zed | Development | linux/amd64 | Zed is a high performance multiplayer code editor written in Rust with built in collaboration and AI assistance.|
| zen | ghcr.io/linuxserver/proot-apps:zen | Network | linux/amd64,linux/arm64 | Zen Browser is a free and open-source fork of Mozilla Firefox with a focus on privacy, customizability and design.|
| zim | ghcr.io/linuxserver/proot-apps:zim | Utility | linux/amd64,linux/arm64 | Zim is a graphical text editor used to maintain a collection of wiki pages.|
| zoom | ghcr.io/linuxserver/proot-apps:zoom | Network | linux/amd64 | Zoom is a proprietary videotelephony software program developed by Zoom Video Communications.|
| zotero | ghcr.io/linuxserver/proot-apps:zotero | Office | linux/amd64 | Zotero is a free, easy-to-use tool to help you collect, organize, annotate, cite, and share research.|


</details>

# For Developers

This repository was made to be cloned and forked with all of the build logic being templated to the repository owner and name. Simply forking this repository and enabling GitHub actions should be enough to get building using GitHub's builders. Also included in this repository is a nightly package check action, in order to use that you will need to set a [GitHub Secret](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) for `PAT` for that bot to work as it needs basic write access to the repo to trigger downstream build actions. The build logic is currently configured to detect changes to the specific folders in `apps` to determine if they need to be built. To build a backlog of the images in this repo when forked removing the package_versions.txt from the apps you want to build and commiting that is likely the easiest approach. `find . -name package_versions.txt -exec git rm {} \;`

When forking all readme updates should be made to the `ci-scripts/README.template` as this is the source file used to write out the readme linked to your forked repo. Also keep in mind all the logic in your forked proot-apps binary and gui installer will be linked to your repostiry and packages.

To generate release tarballs of proot-apps to be ingested with your install command a tag needs to be generated in your fork. This can be achieved with `git tag 0.1.0 && git push origin --tags`. This again will be linked back to your repo in all references for app ingestion. The proot binary is not compiled here, it is ingested prebuilt from [proot-next](https://github.com/selkies-project/proot-next/releases) and verified against its published checksum. Tagged releases ship the latest stable proot-next release while the prerelease published on every commit to master ships the proot-next build of the latest commit to its main branch. Set `PROOT_TAG` in the release workflows to pin a specific proot-next release instead. Releases can also be cut without a tag push by running the Release on Tag workflow manually with the new version number. With the proot-next option checked the last release is rebuilt with the latest stable proot-next and release notes are generated from the upstream release, unchecked it releases the current commit with `release-notes/current`.

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

One other concept to keep in mind is if you want it to work in the application you will need to install it in the build logic. The only storage space PRoot really has access to at runtime is the user's home directory. If the program needs GPU acceleration, you will need to install the drivers (amdgpu, dri gallium, etc). The exception is NVIDIA: the proprietary driver userspace cannot be packaged in the app, so at runtime `proot-apps run` detects an NVIDIA host (or a container started with the NVIDIA runtime) and binds the host driver libraries and Vulkan/EGL/OpenCL ICDs into the app, the same way nvidia-container-runtime does. This only works for glibc based apps (Debian/Ubuntu) launched from a glibc environment, Alpine based apps are skipped and nothing is attempted when proot-apps itself runs inside an Alpine container. Set `PA_NO_NVIDIA` to disable this and `PA_DEBUG` to print what is bound. If the program needs language packs or fonts again you will need to install them. In general this approach is incredibly wasteful when it comes to disk space but without using more complex systems like OverlayFS or bubblewrap (user namespacing) it is necessary.

## Adding a new app

Three are three things needed for an app to work with all build and ingestion logic: 

* A folder with a `Dockerfile` must be created in the `/apps/` directory named after the app name (this is what the user types to install the application)
* Metadata for the application must be added to `/metadata/metadata.yml` file including:
  - name - the app name also tied to the folder used previously, should be a single string all lowercase
  - full_name - the display name for the application
  - arch - what arches to build the application for
  - category - the category the GUI installer groups the application under, the values in use are AI AudioVideo Creative Development Education Game Network Office Science System Utility
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
