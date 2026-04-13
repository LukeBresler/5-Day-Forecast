import XCTest
@testable import __Day_Forecast

final class DateFormatterUtilityTests: XCTestCase {
    func testGetDayOfWeek_matchesSystemFormatter() {
        let date = Date(timeIntervalSince1970: 0) // Jan 1, 1970

        let expected: String = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        }()

        XCTAssertEqual(DateFormatterUtility.getDayOfWeek(from: date), expected)
    }
}

