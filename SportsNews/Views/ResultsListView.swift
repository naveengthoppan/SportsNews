//
//  SportsNewsListView.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 22/09/2022.
//

import Combine
import SwiftUI


struct ResultsListView: View {
    
    @ObservedObject var viewModel: ResultsViewModel
    
    var body: some View {
        
        ZStack {
            if viewModel.showFetchNewsButton {
                Button("Get Results") {
                    viewModel.fetchSportsResults()
                }
            } else if viewModel.isFetching {
                ProgressView("Loading news")
                    .progressViewStyle(.circular)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    VStack {
                        NavigationView {
                            List(viewModel.resultViewModels) { sportResult in
                                    ResultRowView(resultDisplayable: sportResult)
                            }
                            .navigationTitle(viewModel.populateResultHeader())
                        }
                        
                    }
                    
                    .listStyle(.plain)
                }
            }
        }
    }
}

struct SportsNewsListView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsListView(
            viewModel: .init(
                apiService: APIPreviewClient()
            )
        )
    }
}
