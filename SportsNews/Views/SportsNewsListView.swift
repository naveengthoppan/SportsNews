//
//  SportsNewsListView.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 22/09/2022.
//

import Combine
import SwiftUI


struct SportsNewsListView: View {
    
    @ObservedObject var viewModel: SportsNewsListViewModel
    
    var body: some View {
        
        ZStack {
            if viewModel.showFetchNewsButton {
                Button("Get Results") {
                    viewModel.fetchSportsResults()
                }
            } else if viewModel.isFetching {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    List(viewModel.resultsToDisply) { sportResult in
                        Text(sportResult.resultText)
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}

struct SportsNewsListView_Previews: PreviewProvider {
    static var previews: some View {
        SportsNewsListView(viewModel: SportsNewsListViewModel(apiService: APIPreviewClient()))
    }
}
