//
//  WeatherViewModel.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation
import CoreLocation
import Combine

@MainActor
class WeatherViewModel: NSObject, ObservableObject {
    @Published var weatherData: [WeatherData] = []
    @Published var location: CLLocation?
    @Published var errorMessage: String?

    private let weatherService: WeatherService
    private let locationService: LocationServiceProtocol

    init(
        weatherService: WeatherService = WeatherService(),
        locationService: LocationServiceProtocol = LocationService()
    ) {
        self.weatherService = weatherService
        self.locationService = locationService
        super.init()
        self.locationService.delegate = self
    }

    func requestLocation() {
        locationService.requestLocationPermission()
        locationService.requestLocation()
    }

    private func loadWeather(for location: CLLocation) async {
        do {
            let data = try await weatherService.fetchWeather(for: location)
            weatherData = data
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

extension WeatherViewModel: LocationServiceDelegate {
    nonisolated func locationService(_ service: LocationServiceProtocol, didUpdateLocation location: CLLocation) {
        Task { @MainActor in
            self.location = location
            await self.loadWeather(for: location)
        }
    }

    nonisolated func locationService(_ service: LocationServiceProtocol, didFailWith error: Error) {
        Task { @MainActor in
            self.errorMessage = error.localizedDescription
        }
    }
}
