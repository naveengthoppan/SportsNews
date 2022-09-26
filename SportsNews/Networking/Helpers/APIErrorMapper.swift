//
//  APIErrorMapper.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 01/08/2022.
//

import Foundation

struct APIErrorMapper {
    // MARK: - Types
    
    enum Context {
        case results
    }
    
    // MARK: - Properties
    
    let error: APIError
    let context: Context
    
    // MARK: - Public API
    
    var message: String {
        switch error {
        case .unreachable:
            return "You need to have a network connection."
        case .unknown,
                .failedRequest,
                .invalidResponse:
            switch context {
            case .results:
                return "The list of results could not be fetched."
            }
        }
    }
    
}
