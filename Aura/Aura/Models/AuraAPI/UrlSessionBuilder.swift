//
//  UrlSessionBuilder.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 26/01/2024.
//

import Foundation

class UrlSessionBuilder {

    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
    }

    struct UrlSessionConfig {
        let httpMethod: HttpMethod
        let sUrl: String
        let parameters: [String: Any]?
        let withAuth: Bool
    }
    
    /// Get data from url session data task
    func buildUrlSession(config: UrlSessionConfig, _ completion: @escaping (Result<Data, Error>) -> ()) {
        // get url
        guard let url = URL(string: config.sUrl) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        // get url request
        let urlRequest = buildRequest(httpMethod: config.httpMethod, url: url, param: config.parameters, withAuth: config.withAuth)
        
        // crate url session task
        URLSession.shared.dataTask(with: urlRequest) { dataResult, urlResponse, error in
            if let err = error {
                completion(.failure(ApiError.serverErr))
                return
            }
            guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(ApiError.badStatusCode))
                return
            }
            guard let data = dataResult else {
                completion(.failure(ApiError.invalidData))
                return
            }
            completion(.success(data))
        }
        .resume()
    }
}

// MARK: Private methods

private extension UrlSessionBuilder {

    private func buildRequest(httpMethod: HttpMethod, url: URL, param: [String: Any]?, withAuth: Bool) -> URLRequest {
        // set url request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // add parameters if exist
        if let parameters = param {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }

        // add header if need authorization
        if withAuth {
            urlRequest.allHTTPHeaderFields = [BodyKey.token: KeychainManager.token]
        }
        return urlRequest
    }
}
