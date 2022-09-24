//
//  APIService.swift
//  Cocoacasts
//
//  Created by Naveen George Thoppan on 22/07/2022.
//

import Foundation
import Combine

protocol APIService {
    func fetchResults() -> AnyPublisher<SportsResults, APIError>
    
    
}
