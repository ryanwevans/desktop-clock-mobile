# Desktop Clock Mobile

A minimal post-modern clock and calendar display built with Flutter. Black background, tick-mark dial (no numerals), smooth red second hand, and a current-month calendar with Sunday as the first day of the week.

## Features

- Analog clock with 60 tick marks (no hour/minute numbers)
- Smooth sweeping second hand (red); hour and minute hands in white
- Calendar showing the current month only; today highlighted in red
- Responsive layout: portrait (clock top / calendar bottom), landscape (clock left / calendar right)
- Web support for local browser preview

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started) (3.16+ recommended)
- Chrome (or another browser) for web preview

Enable web if needed:

```bash
flutter config --enable-web
```

## Run locally in the browser

From the project root:

```bash
flutter pub get
flutter run -d chrome
```

Or use the helper script:

```bash
chmod +x scripts/run_web.sh
./scripts/run_web.sh
```

For a fixed local URL (useful when Chrome is not the default target):

```bash
flutter run -d web-server --web-port=8080
```

Then open the URL printed in the terminal (typically `http://localhost:8080`).

## Run on a device or simulator

```bash
flutter run
```

Pick a connected device when prompted, or pass `-d <device_id>`.

## Tests

```bash
flutter test
```

## Project structure

```
lib/
  main.dart                 # App shell and orientation layouts
  theme/app_colors.dart     # Color palette
  widgets/
    clock_face.dart         # Custom-painted analog clock
    month_calendar.dart     # Current-month grid calendar
web/                        # Web entry (index.html, manifest)
```
