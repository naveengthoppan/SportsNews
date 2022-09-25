//
//  GameResult.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 25/09/2022.
//

import Foundation

struct GameResult {
    var id: UUID
    var date: Date
    var resultText: String
    
    init(f1Resut: F1Result) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm:ss a"
        self.id = UUID()
        self.date = dateFormatter.date(from: f1Resut.publicationDate)!
        self.resultText = f1Resut.winner + " wins " + f1Resut.tournament + " by \(f1Resut.seconds)" + " seconds"
    }
    
    init(nbaResult: NbaResult) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm:ss a"
        self.id = UUID()
        self.date = dateFormatter.date(from: nbaResult.publicationDate)!
        self.resultText = nbaResult.mvp + " leads " + nbaResult.winner + " to game \(nbaResult.gameNumber)" + " win in the " + nbaResult.tournament
    }
    
    init(tennisResult: Tennis) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm:ss a"
        self.id = UUID()
        self.date = dateFormatter.date(from: tennisResult.publicationDate)!
        self.resultText = tennisResult.tournament + ": " + tennisResult.winner + " wins against " + tennisResult.looser + " in \(tennisResult.numberOfSets)" + " sets"
    }
}
