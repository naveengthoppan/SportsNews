//
//  APIEndPoint.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 26/07/2022.
//

import Foundation

enum APIEndPoint {
    
    case results
    
    func request() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.addHeaders(headers)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    
    private var url: URL {
        Environment.apiBaseURL.appendingPathComponent(path)
    }
    
    private var path: String {
        switch self {
        case .results:
            return "results"
        }
    }
    
    private var headers: [String: String] {
        let headers: [String: String] = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    private var httpMethod: HTTPMethod {
        switch self {
        case .results:
            return .post
        }
    }
}

extension URLRequest {
    
    mutating func addHeaders(_ headers: [String: String]) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }
    
}
