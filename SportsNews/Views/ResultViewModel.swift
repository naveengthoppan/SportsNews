//
//  SportsNewsRowViewModel.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 25/09/2022.
//

import Foundation

struct ResultViewModel: Identifiable {
    
    private let gameResult: GameResult
    
    var id: UUID {
        gameResult.id
    }
    
    init(gameResult: GameResult) {
        self.gameResult = gameResult
    }
}

extension ResultViewModel: GameResultDisplayable {
    var resultText: String {
        gameResult.resultText
    }
}
