//
//  NbaResult.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 25/09/2022.
//

import Foundation

struct NbaResult: Decodable {
    var gameResult: GameResult
    private let expectedFormat = Date.FormatStyle().month().day().year().hour().minute().second()
    
    enum CodingKeys: String, CodingKey {
        case publicationDate = "publicationDate"
        case tournament = "tournament"
        case winner = "winner"
        case gameNumber = "gameNumber"
        case mvp = "mvp"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let publicationDateString = try values.decodeIfPresent(String.self, forKey: .publicationDate) ?? ""
        let date = try Date(publicationDateString, strategy: expectedFormat)
        
        let tournament = try values.decodeIfPresent(String.self, forKey: .tournament) ?? ""
        let winner = try values.decodeIfPresent(String.self, forKey: .winner) ?? ""
        let gameNumber = try values.decodeIfPresent(Int.self, forKey: .gameNumber) ?? 0
        let mvp = try values.decodeIfPresent(String.self, forKey: .mvp) ?? ""
        
        let resultText = mvp + " leads " + winner + " to game \(gameNumber)" + " win in the " + tournament
        
        gameResult = GameResult(date: date, resultText: resultText)
    }
}
