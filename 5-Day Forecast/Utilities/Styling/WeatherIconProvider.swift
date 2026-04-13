//
//  WeatherIconProvider.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation
import SwiftUI

class WeatherIconProvider {
    static func weatherIcon(for weatherMain: String?) -> Image {
        guard let weatherMain = weatherMain else {
            return Image("sunny")
        }
        switch weatherMain.lowercased() {
        case "clouds":
            return Image("Property 1=05.partial-cloudy-light")
        case "rain":
            return Image("Property 1=18.heavy-rain-light")
        case "clear":
            return Image("Property 1=01.sun-light")
        default:
            return Image("sunny")
        }
    }
}
