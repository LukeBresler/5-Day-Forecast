import XCTest
@testable import __Day_Forecast

final class ForecastGrouperTests: XCTestCase {
    func testGetDailyForecasts_returnsAtMostFiveDays_sorted_andClosestToNoon() {
        let calendar = Calendar.current

        func makeWeatherData(on date: Date, temp: Double, dtOffsetSeconds: Int = 0) -> WeatherData {
            let dt = Int(date.addingTimeInterval(TimeInterval(dtOffsetSeconds)).timeIntervalSince1970)
            return WeatherData(
                dt: dt,
                main: MainWeather(temp: temp),
                weather: [Weather(id: 800, main: "Clear", description: "clear", icon: "01d")]
            )
        }

        let startOfToday = calendar.startOfDay(for: Date())

        // Create 6 days worth of data, each with 9am, 12pm, and 3pm.
        var all: [WeatherData] = []
        for dayOffset in 0..<6 {
            let dayStart = calendar.date(byAdding: .day, value: dayOffset, to: startOfToday)!

            let nine = calendar.date(byAdding: .hour, value: 9, to: dayStart)!
            let noon = calendar.date(byAdding: .hour, value: 12, to: dayStart)!
            let three = calendar.date(byAdding: .hour, value: 15, to: dayStart)!

            all.append(makeWeatherData(on: nine, temp: 9))
            all.append(makeWeatherData(on: noon, temp: 12))
            all.append(makeWeatherData(on: three, temp: 15))
        }

        let daily = ForecastGrouper.getDailyForecasts(from: all.shuffled())

        XCTAssertEqual(daily.count, 5)

        // Ensure ascending by day.
        for i in 1..<daily.count {
            XCTAssertLessThanOrEqual(calendar.startOfDay(for: daily[i - 1].date), calendar.startOfDay(for: daily[i].date))
        }

        // Ensure each chosen entry is the noon one (temp=12) for those days.
        XCTAssertTrue(daily.allSatisfy { Int($0.main.temp) == 12 })
    }
}

