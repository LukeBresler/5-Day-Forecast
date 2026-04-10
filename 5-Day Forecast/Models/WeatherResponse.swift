//
//  WeatherResponse.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation

struct WeatherResponse: Codable {
    var list: [WeatherData]
}

struct WeatherData: Codable, Identifiable {
    var dt: Int
    var main: MainWeather
    var weather: [Weather]
    
    var id: Int { dt }
    
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(dt))
    }
}

struct MainWeather: Codable {
    var temp: Double

    
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
