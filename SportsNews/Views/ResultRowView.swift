//
//  ResultView.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 25/09/2022.
//

import SwiftUI

struct ResultRowView: View {
    
    let resultDisplayable: GameResultDisplayable
    
    var body: some View {
        Text(resultDisplayable.resultText)
    }
}

struct ResultView_Previews: PreviewProvider {
    
    private struct PreviewDisplayable: GameResultDisplayable {
        var resultText: String {
            "Roland Garros: Rafael Nadal wins against Schwartzman in 3 sets"
        }
    }
    static var previews: some View {
        ResultRowView(resultDisplayable: PreviewDisplayable())
    }
}
