//
//  GameResult.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 25/09/2022.
//

import Foundation

struct GameResult {
    var id: UUID = UUID()
    var date: Date
    var resultText: String
    
    private let expectedFormat = Date.FormatStyle().month().day().year().hour().minute().second()
    
    init(date: Date, resultText: String) {
        self.date = date
        self.resultText = resultText
    }
}
