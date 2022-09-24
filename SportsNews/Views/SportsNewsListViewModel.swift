//
//  SportsNewsListViewModel.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 22/09/2022.
//

import Combine
import Foundation

class SportsNewsListViewModel: ObservableObject {
    // MARK: - Properties

    
    @Published private(set) var sportsResults: SportsResults?
    
    @Published private(set) var resultsToDisply: [GameResult] = []

    @Published private(set) var isFetching: Bool = false
    
    @Published private(set) var errorMessage: String?
    
    @Published private(set) var showFetchNewsButton: Bool = true

    // MARK: -

//    var episodeRowViewModels: [EpisodeRowViewModel] {
//        episodes.map { EpisodeRowViewModel(episode: $0) }
//    }
    
    private let apiService: APIService

    // MARK: -

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(apiService: APIService) {
            self.apiService = apiService
            
        }

    // MARK: - Helper Methods

    func fetchSportsResults() {
        isFetching = true

            apiService.fetchResults()
                .sink(receiveCompletion: { [weak self] completion in
                    self?.isFetching = false

                    switch completion {
                    case .finished:
                        print("Successfully Fetched News")
                    case .failure(let error):
                        print("Unable to Fetch News \(error)")
                        self?.errorMessage = APIErrorMapper(
                            error: error,
                            context: .results
                        ).message
                    }
                }, receiveValue: { [weak self] results in
                    self?.isFetching = false 
                    self?.sportsResults = results
                    self?.resultsToDisply = results.results
                    self?.showFetchNewsButton = false
                }).store(in: &subscriptions)
        
    }
    
}
