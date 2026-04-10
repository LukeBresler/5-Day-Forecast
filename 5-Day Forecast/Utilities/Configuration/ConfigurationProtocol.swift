//
//  ConfigurationProtocol.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation
import CoreLocation

protocol ConfigurationProtocol {
    var weatherAPIKey: String { get }
    var weatherBaseURL: String { get }
}

struct Configuration: ConfigurationProtocol {
    let weatherAPIKey: String
    let weatherBaseURL: String
    
    static let `default` = Configuration(
        weatherAPIKey: Configuration.loadAPIKey(),
        weatherBaseURL: "https://api.openweathermap.org/data/2.5"
    )

    private static func loadAPIKey() -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String,
              !apiKey.isEmpty else {
            fatalError("Missing WEATHER_API_KEY in Info.plist")
        }
        return apiKey
    }
}
