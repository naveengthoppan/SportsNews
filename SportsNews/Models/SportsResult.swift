//
//  SportsResult.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 22/09/2022.
//

import Foundation


struct SportsResults: Decodable {
    
    let results: [GameResult]

    
    enum CodingKeys: String, CodingKey {
        case f1Results = "f1Results"
        case nbaResults = "nbaResults"
        case tennis = "Tennis"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let f1Results = try values.decodeIfPresent([F1Result].self, forKey: .f1Results) ?? [F1Result]()
        let nbaResults = try values.decodeIfPresent([NbaResult].self, forKey: .nbaResults) ?? [NbaResult]()
        let tennis = try values.decodeIfPresent([Tennis].self, forKey: .tennis) ?? [Tennis]()
        
        let f1ResultObjects = f1Results.compactMap({$0.gameResult})
        let nbaResultObjects = nbaResults.compactMap({$0.gameResult})
        let tennisResultObjects = tennis.compactMap({$0.gameResult})
        
        results = f1ResultObjects + nbaResultObjects + tennisResultObjects
    }
}

// MARK: - F1Result
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
    
    // MARK: - NbaResult
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
    
    // MARK: - Tennis
struct Tennis: Decodable {
    var gameResult: GameResult
    private let expectedFormat = Date.FormatStyle().month().day().year().hour().minute().second()
    
    enum CodingKeys: String, CodingKey {
        case publicationDate = "publicationDate"
        case tournament = "tournament"
        case winner = "winner"
        case numberOfSets = "numberOfSets"
        case looser = "looser"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let publicationDateString = try values.decodeIfPresent(String.self, forKey: .publicationDate) ?? ""
        let date = try Date(publicationDateString, strategy: expectedFormat)
        
        let tournament = try values.decodeIfPresent(String.self, forKey: .tournament) ?? ""
        let winner = try values.decodeIfPresent(String.self, forKey: .winner) ?? ""
        let numberOfSets = try values.decodeIfPresent(Int.self, forKey: .numberOfSets) ?? 0
        let looser = try values.decodeIfPresent(String.self, forKey: .looser) ?? ""
        
        let resultText = tournament + ": " + winner + " wins against " + looser + " in \(numberOfSets)" + " sets"
        
        gameResult = GameResult(date: date, resultText: resultText)
    }
}
