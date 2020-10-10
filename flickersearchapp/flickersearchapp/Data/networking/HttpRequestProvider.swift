//
//  HttpRequestProvider.swift
//  flickersearchapp
//
//  Created by José Marques on 10/10/2020.
//

import Foundation



protocol HttpProviderProtocol {
    func fetch<T>(endpoint: String,  completionHandler: @escaping (Result<T, HttpProviderError>) -> Void) where T: Codable
}

enum HttpProviderError: Error {
    case unavailable
    case decoding
}

// MARK: - HttpProviderProtocol methods
class HttpProvider: HttpProviderProtocol {
    func fetch<T>(endpoint: String, completionHandler: @escaping (Result<T, HttpProviderError>) -> Void) where T: Codable {
        RequestBuilder(forPath: endpoint) { (result) in
            switch result {
            case .success(let request):
                URLSession.shared.dataTask(with: request) { (data, _, error) in
                    DispatchQueue.main.async {
                        if let data = data {
                            do {
                                let decoded = try JSONDecoder().decode(T.self, from: data)
                                completionHandler(.success(decoded))
                            } catch {
                                print("[ERR] HttpProvider >> \(error.localizedDescription)")
                                completionHandler(.failure(.decoding))
                            }
                        } else {
                            completionHandler(.failure(.unavailable))
                        }
                    }
                }.resume()
            case.failure(let error):
                completionHandler(.failure(error))
            }

        }
    }

    private func RequestBuilder(forPath url: String, _ completion: @escaping (Result<URLRequest, HttpProviderError>) -> Void)  {
        let endpoint = URL(string: url)
        if let requestURL = endpoint {
            var urlRequest = URLRequest(url: requestURL)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            completion(.success(urlRequest))
        } else {
            completion(.failure(.unavailable))
        }
    }
}
