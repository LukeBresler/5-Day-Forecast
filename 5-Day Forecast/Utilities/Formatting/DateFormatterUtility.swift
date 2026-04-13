//
//  DateFormatterUtility.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation

class DateFormatterUtility {
    static func getDayOfWeek(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}