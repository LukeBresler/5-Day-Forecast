//
//  NetworkServiceProtocol.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T
}

enum NetworkError: LocalizedError {
    case invalidResponse
    case httpError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid response."
        case .httpError(let statusCode):
            return "The weather service request failed with status code \(statusCode)."
        }
    }
}

class NetworkService: NetworkServiceProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
