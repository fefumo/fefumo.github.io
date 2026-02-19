#prog 
# 🗂 Шпаргалка по настройкам приложений
## 🌿 Универсальные правила (XDG Base Directory)

- Конфиги: `~/.config/`
- Данные (иконки, .desktop, базы): `~/.local/share/`
- Кэш: `~/.cache/`
- Системные глобальные аналоги: `/etc/xdg/`, `/usr/share/`

> Если не знаешь тип программы → смотри сначала в `~/.config/` и `.desktop`.
---

## 🎨 GTK-программы (GIMP, Nautilus, Telegram-Desktop, Obsidian UI тоже отчасти)

- Основные конфиги:
    - `~/.config/gtk-3.0/settings.ini`
    - `~/.config/gtk-4.0/settings.ini`
- Старое (иногда ещё работает): `~/.gtkrc-2.0`
- Системные: `/etc/gtk-3.0/settings.ini`
- Управляются переменными:
    - `GDK_SCALE` → integer (1, 2, …)
    - `GDK_DPI_SCALE` → дробь (1.25, 1.5 …)
---

## ⚙️ Qt-программы (KDE, Telegram, VLC, KeePassXC)

- Читают `~/.config/qt5ct/` или `~/.config/qt6ct/` (если установлен `qt5ct` / `qt6ct`).
- Глобальные: `/etc/xdg/qt5ct/`
- Управляются переменными окружения:
    - `QT_QPA_PLATFORM=wayland` или `xcb`
    - `QT_SCALE_FACTOR=1.5`
    - `QT_AUTO_SCREEN_SCALE_FACTOR=0/1`
    - `QT_ENABLE_HIGHDPI_SCALING=1`

---

## ⚡ Electron-программы (Obsidian, VSCode, Slack, Discord, Spotify)

- Главное: они почти не уважают GTK/Qt настройки, всё через **флаги запуска** в `.desktop`.
- Где искать:
    - `~/.local/share/applications/<app>.desktop` (твоя версия с Exec=…)
    - `/usr/share/applications/<app>.desktop` (системный оригинал)
- Важные флаги:
    - `--enable-features=UseOzonePlatform`
    - `--ozone-platform=wayland`
    - `--force-device-scale-factor=1.5` (если всё ещё мелко/огромно)
---

## 🖥 X11-программы (xterm, urxvt, feh, старые тулзы)

- Конфиги:
    - `~/.Xresources` (читается через `xrdb -merge ~/.Xresources`)
    - `~/.Xdefaults` (старое)
    - Что можно задавать: DPI, шрифты, цвета.
- Автозагрузка: `~/.xinitrc` или `~/.xprofile`
---

## 🌌 Wayland / Hyprland

- Всё по XDG: `~/.config/hypr/hyprland.conf`
- Там же можно прописывать env для приложений:
```
	env = QT_QPA_PLATFORM,wayland
    env = GDK_SCALE,1
    env = GDK_DPI_SCALE,1.5
    env = XCURSOR_SIZE,48
```
- Для скейлинга монитора: секция `monitor` в `hyprland.conf`.
---

## 📦 Flatpak

- Конфиги: `~/.var/app/<AppID>/config/`
- Данные: `~/.var/app/<AppID>/data/`
- Отличаются от системных, потому что Flatpak = sandbox.
---

# 🔍 Как быстро понять «куда лезть»

1. Проверяешь `.desktop` файл в `~/.local/share/applications/` или `/usr/share/applications/`.  
    → если там `Exec=electron` или `Exec=… --ozone-platform=wayland`, значит это **Electron**.
2. Если в about/`--version` написано Qt → смотри `qt5ct` и env.
3. Если Gtk → смотри `~/.config/gtk-3.0/settings.ini`.
4. Если старый X11 (xterm, feh) → смотри `.Xresources`.
---

⚡ Итог:

- **GTK/Qt** → уважают XDG + env.
- **Electron** → правишь `.desktop` + флаги запуска.
- **X11-олдскул** → `.Xresources`.
- **Wayland** → env внутри `hyprland.conf`.