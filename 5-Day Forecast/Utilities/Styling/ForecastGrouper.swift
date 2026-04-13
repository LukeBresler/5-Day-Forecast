//
//  ForecastGrouper.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation

class ForecastGrouper {
   static func getDailyForecasts(from weatherData: [WeatherData]) -> [WeatherData] {
        // Group forecasts by day and take the noon forecast for each day
        let calendar = Calendar.current
        var dailyForecasts: [WeatherData] = []
        let groupedByDay = Dictionary(grouping: weatherData) { weather in
            calendar.startOfDay(for: weather.date)
        }
        
        // Sort days and take one reading per day (preferably around noon)
        let sortedDays = groupedByDay.keys.sorted()
        for day in sortedDays.prefix(5) {
            if let forecasts = groupedByDay[day] {
                // Try to get the forecast closest to noon
                let noonForecast = forecasts.min(by: { forecast1, forecast2 in
                    let hour1 = calendar.component(.hour, from: forecast1.date)
                    let hour2 = calendar.component(.hour, from: forecast2.date)
                    return abs(hour1 - 12) < abs(hour2 - 12)
                })
                if let forecast = noonForecast {
                    dailyForecasts.append(forecast)
                }
            }
        }
        return dailyForecasts
    }
}
