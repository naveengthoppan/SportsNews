//
//  APIPreviewClient.swift
//  Cocoacasts
//
//  Created by Naveen George Thoppan on 23/07/2022.
//

import Foundation
import Combine

struct APIPreviewClient: APIService {
    
    func fetchResults() -> AnyPublisher<SportsResults, APIError> {
        publisher(for: "sportsResults")
    }
}


fileprivate extension APIPreviewClient {
    
    func publisher<T:Decodable>(for resource: String) -> AnyPublisher<T, APIError> {
        Just(stubData(for: resource))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func stubData<T:Decodable>(for resource: String) -> T {
        guard
            let url = Bundle.main.url(forResource: resource, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let stubData = try? JSONDecoder().decode(T.self, from: data)
        else {
            fatalError("Unable to Load Episodes")
        }
        return stubData
    }
}
