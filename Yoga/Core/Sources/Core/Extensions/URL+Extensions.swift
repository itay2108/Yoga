//
//  URL+Extensions.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

public extension URL {
    init?(optionalString: String?) {
        guard let string = optionalString else {
            return nil
        }
        
        self.init(string: string)
    }


    /// Adds the given dictionary of parameters to the URL as query parameters.
    /// - Parameter parameters: A dictionary containing key-value pairs to be added as query parameters.
    /// - Returns: A new URL with the query parameters added, or `nil` if the URL is invalid.
    func appendingQueryParameters(_ parameters: [String: Any]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }

        var queryItems = urlComponents.queryItems ?? []
        for (key, value) in parameters {
            let valueString = "\(value)"
            let queryItem = URLQueryItem(name: key, value: valueString)
            queryItems.append(queryItem)
        }
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }

    func value(forParameterNamed componentName: String) -> String? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        return components?.queryItems?.first(where: { $0.name == componentName })?.value
    }
}

// MARK: - Redirects

public extension URL {

    /// - Returns: The Redirect URL if exists
    func redirectUrl() async -> URL? {
        var request = URLRequest(url: self)
        request.httpMethod = "HEAD"

        let session = URLSession(configuration: .default, delegate: RedirectBlocker(), delegateQueue: nil)

        do {
            let (_, response) = try await session.data(for: request)

            if let httpResponse = response as? HTTPURLResponse,
               (300...399).contains(httpResponse.statusCode),
               let location = httpResponse.allHeaderFields["Location"] as? String {
                return URL(string: location)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }

    static func encoding(parameters: [String: Any], toStringUrl urlString: String) throws -> URL {
        guard var components = URLComponents(string: urlString) else { throw URLError(.badURL) }
        var items = components.queryItems ?? []
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        components.queryItems = items
        guard let finalUrl = components.url else { throw URLError(.badURL) }
        return finalUrl
    }

    private class RedirectBlocker: NSObject, URLSessionDelegate, URLSessionTaskDelegate, @unchecked Sendable {
        func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            // Prevent automatic redirect following
            completionHandler(nil)
        }
    }
}

public extension URLComponents {
    func decodeQuery<T: Decodable>(as type: T.Type) -> T? {
        guard let queryItems = self.queryItems else { return nil }

        let dict: [String: String] = Dictionary(uniqueKeysWithValues: queryItems.compactMap {
            guard let value = $0.value else { return nil }
            return ($0.name, value)
        })

        do {
            let data = try JSONSerialization.data(withJSONObject: dict)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Failed to decode query: \(error)")
            return nil
        }
    }
}
