//
//  SportsResult.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 22/09/2022.
//

import Foundation


struct SportsResults: Decodable {
    
    let f1Results: [F1Result]
    let nbaResults: [NbaResult]
    let tennisResults: [Tennis]
    
    enum CodingKeys: String, CodingKey {
        case f1Results, nbaResults
        case tennisResults = "Tennis"
    }
}

// MARK: - F1Result
struct F1Result: Codable {
    let publicationDate: String
    let seconds: Double
    let tournament, winner: String
}
    
    // MARK: - NbaResult
struct NbaResult: Codable {
    let gameNumber: Int
    let looser, mvp, publicationDate, tournament: String
    let winner: String
}
    
    // MARK: - Tennis
struct Tennis: Codable {
    let looser: String
    let numberOfSets: Int
    let publicationDate, tournament, winner: String
}
