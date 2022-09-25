//
//  F1Result.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 25/09/2022.
//

import Foundation

struct F1Result: Decodable {
    var gameResult: GameResult
    private let expectedFormat = Date.FormatStyle().month().day().year().hour().minute().second()
    
    enum CodingKeys: String, CodingKey {
        case publicationDate = "publicationDate"
        case tournament = "tournament"
        case winner = "winner"
        case seconds = "seconds"
    }
    
    init(from decoder: Decoder) throws {
    
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let publicationDateString = try values.decodeIfPresent(String.self, forKey: .publicationDate) ?? ""
        let date = try Date(publicationDateString, strategy: expectedFormat)
        
        let tournament = try values.decodeIfPresent(String.self, forKey: .tournament) ?? ""
        let winner = try values.decodeIfPresent(String.self, forKey: .winner) ?? ""
        
        let seconds = try values.decodeIfPresent(Double.self, forKey: .seconds) ?? 0
        
        let resultText = winner + " wins " + tournament + " by \(seconds)" + " seconds"
        
        gameResult = GameResult(date: date, resultText: resultText)
        
    }
}
