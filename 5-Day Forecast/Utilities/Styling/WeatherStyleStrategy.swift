//
//  WeatherStyleStrategy.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation
import SwiftUI

protocol WeatherStyleStrategy {
    var backgroundImage: Image { get }
}

struct CloudyWeatherStyle: WeatherStyleStrategy {
    var backgroundImage: Image { Image("Cloudy")}
}

struct RainyWeatherStyle: WeatherStyleStrategy {
    var backgroundImage: Image { Image("Rainy")}
}

struct ClearWeatherStyle: WeatherStyleStrategy {
    var backgroundImage: Image { Image("Sunny")}
}

class WeatherBackground {
    func style(for WeatherMain: String) -> WeatherStyleStrategy {
        switch WeatherMain.lowercased() {
        case "clouds":
            return CloudyWeatherStyle()
        case "rain":
            return RainyWeatherStyle()
        case "clear":
            return ClearWeatherStyle()
        default:
            return ClearWeatherStyle()
        }
    }
}
