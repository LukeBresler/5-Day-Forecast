# 5-Day Forecast

A simple iOS **5-day weather forecast** app built with **SwiftUI** and an **MVVM** architecture. It fetches forecast data from **OpenWeatherMap** and groups results into one forecast per day (closest to noon).

## Features

- **5-day forecast** list UI
- **Location-based** weather (uses Core Location)
- **MVVM** separation (`WeatherViewModel` + services)
- **Network layer with HTTP status validation**
- **Unit tests** for core, non-UI logic

## Tech stack

- **SwiftUI**
- **MVVM** (`View Models/`, `UI/`, `Utilities/Services/`)
- **Async/await** networking
- **XCTest** unit tests

## Project structure (high level)

- `5-Day Forecast/UI/`: SwiftUI views (`WeatherView`, `ForecastListView`, `LoadingView`)
- `5-Day Forecast/View Models/`: `WeatherViewModel`
- `5-Day Forecast/Utilities/Services/`: `NetworkService`, `WeatherService`, `LocationService`
- `5-Day Forecast/Utilities/Configuration/`: `Configuration` + `Secrets.xcconfig` (gitignored)
- `5-Day ForecastTests/`: unit tests

## Setup (API key)

This project expects an OpenWeatherMap API key via a **gitignored** xcconfig.

1. Ensure `5-Day Forecast/Utilities/Configuration/Secrets.xcconfig` exists (it is ignored by git).
2. Add your key:

```xcconfig
WEATHER_API_KEY = <your_openweather_api_key>
```

The app reads the value from `Info.plist` (`WEATHER_API_KEY` -> `$(WEATHER_API_KEY)`), which is populated via the target’s base configuration.

## Running

1. Open `5-Day Forecast.xcodeproj` in Xcode
2. Select an iOS Simulator or device
3. Run (`⌘R`)

## Tests

Run unit tests via **Product → Test** (`⌘U`).

Tests include:

- `NetworkServiceTests`: HTTP status handling + decode success
- `ForecastGrouperTests`: daily grouping behavior (closest-to-noon selection)
- `DateFormatterUtilityTests`: day-of-week formatting

