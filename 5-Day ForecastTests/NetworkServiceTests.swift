import XCTest
@testable import __Day_Forecast

final class NetworkServiceTests: XCTestCase {
    private final class URLProtocolStub: URLProtocol {
        static var handler: (@Sendable (URLRequest) throws -> (HTTPURLResponse, Data))?

        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

        override func startLoading() {
            guard let handler = Self.handler else {
                XCTFail("URLProtocolStub.handler was not set")
                return
            }

            do {
                let (response, data) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }

        override func stopLoading() {}
    }

    private func makeSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: config)
    }

    func testFetch_whenStatusIs2xx_decodesBody() async throws {
        struct Payload: Codable, Equatable {
            let value: String
        }

        let url = URL(string: "https://example.com/test")!
        let expected = Payload(value: "ok")
        let data = try JSONEncoder().encode(expected)

        URLProtocolStub.handler = { request in
            XCTAssertEqual(request.url, url)
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let sut = NetworkService(session: makeSession())
        let decoded: Payload = try await sut.fetch(from: url)
        XCTAssertEqual(decoded, expected)
    }

    func testFetch_whenStatusIsNon2xx_throwsHttpError() async {
        let url = URL(string: "https://example.com/test")!

        URLProtocolStub.handler = { _ in
            let response = HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        let sut = NetworkService(session: makeSession())

        do {
            let _: WeatherResponse = try await sut.fetch(from: url)
            XCTFail("Expected fetch to throw")
        } catch let error as NetworkError {
            switch error {
            case .httpError(let statusCode):
                XCTAssertEqual(statusCode, 401)
            default:
                XCTFail("Expected httpError, got \(error)")
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }
}

