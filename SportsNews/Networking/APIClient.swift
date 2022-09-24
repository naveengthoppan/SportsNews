//
//  APIClient.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 22/07/2022.
//

import Foundation
import Combine

final class APIClient {
    
    private func request<T: Decodable>(_ endpoint: APIEndPoint) -> AnyPublisher<T, APIError> {
        do {
            let request = try endpoint.request()
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .retry(1)
                .tryMap { data, response -> T in
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        throw APIError.failedRequest
                    }
                    guard statusCode.isSuccess else {
                        throw APIError.failedRequest
                    }
                    
                    if statusCode == 204, let noContent = NoContent() as? T {
                        return noContent
                    }
                    
                    do {
                        return try JSONDecoder().decode(T.self, from: data)
                    } catch {
                        print("Unable to Decode Response \(error)")
                        throw APIError.invalidResponse
                    }
                }
                .mapError { error -> APIError in
                    switch error {
                    case let apiError as APIError:
                        return apiError
                    case URLError.notConnectedToInternet:
                        return .unreachable
                    default:
                        return .failedRequest
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            if let apiError = error as? APIError {
                return Fail(error: apiError)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
        }
    }
}

extension APIClient: APIService {
    func fetchResults() -> AnyPublisher<SportsResults, APIError> {
        request(.results)
    }
}
