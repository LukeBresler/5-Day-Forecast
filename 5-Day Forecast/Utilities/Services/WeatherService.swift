//
//  WeatherService.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation
import CoreLocation

class WeatherService {
    private let networkService: NetworkServiceProtocol
    private let configuration: ConfigurationProtocol
    private let locationService: LocationServiceProtocol

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        locationService: LocationServiceProtocol = LocationService(),
        configuration: ConfigurationProtocol = Configuration.default
    ) {
        self.networkService = networkService
        self.locationService = locationService
        self.configuration = configuration
    }

    func fetchWeather(for location: CLLocation) async throws -> [WeatherData] {
        let urlString = "\(configuration.weatherBaseURL)/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(configuration.weatherAPIKey)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var response: WeatherResponse = try await networkService.fetch(from: url)

        // Convert temperatures from Kelvin to Celsius
        response.list = response.list.map { weatherData in
            var mutableWeatherData = weatherData
            mutableWeatherData.main.temp -= 273.15
            return mutableWeatherData
        }

        return response.list
    }
}
