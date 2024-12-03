//
//  Untitled.swift
//  DiscogsApp
//
//  Created by Juan José Granados Moreno on 1/12/24.
//

import Foundation

protocol Service {
    
    func request<T: Decodable>(
        endpoint: String,
        queryParameters: [String: String]?,
        responseType: T.Type
    ) async throws -> T
    
}

final class APIService: Service {
    
    private let baseURL = "https://api.discogs.com"
    private let authToken = "Discogs token=yAGaNILySrVNYcqowYUDDKdgjBuVSBhdkpapsoPo"
    private let userAgent = "RocollaApp/1.0 (Juanjo; juanjogramo@gmail.com)"
    
    /// Makes a network request to a specified endpoint and decodes the response into the provided type.
    /// - Parameters:
    ///   - endpoint: The endpoint to append to the base URL.
    ///   - queryParameters: A dictionary of query parameters to include in the request.
    ///   - responseType: The type to decode the response into.
    /// - Returns: A decoded object of the specified type.
    func request<T: Decodable>(
        endpoint: String,
        queryParameters: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        // Construct URL
        guard var urlComponents = URLComponents(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
        print("URL: ", request.url?.absoluteString ?? "NA")
        print("HTTPMethod: ", request.httpMethod ?? "NA")
        print("Headers: ", request.allHTTPHeaderFields ?? "NA")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else {
                    let responseBody = String(data: data, encoding: .utf8) ?? "Unknown error"
                    print("Error: \(httpResponse.statusCode) - \(responseBody)")
                    throw NSError(domain: "DiscogsAPI", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: responseBody])
                }
            }
            print("Response: ", String(data: data, encoding: .utf8) ?? "NA")
            let decodedResponse = try JSONDecoder().decode(responseType, from: data)
            return decodedResponse
        } catch {
            print("Request failed: \(error.localizedDescription)")
            throw error
        }
    }
    
}

