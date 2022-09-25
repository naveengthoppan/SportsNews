//
//  SportsNewsListViewModel.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 22/09/2022.
//

import Combine
import Foundation

@MainActor class ResultsViewModel: ObservableObject {
    // MARK: - Properties
        
    @Published private(set) var resultViewModels: [ResultViewModel] = []
    
    @Published private(set) var isFetching: Bool = false
    
    @Published private(set) var errorMessage: String?
    
    @Published private(set) var showFetchNewsButton: Bool = true
    
    private(set) var newsDate: Date?
    
    private let apiService: APIService
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Initialization
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    // MARK: - Helper Methods
    
    func fetchSportsResults() {
        showFetchNewsButton = false
        isFetching = true
        
        apiService.fetchResults()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                
                switch completion {
                case .finished:
                    self?.showFetchNewsButton = false
                    self?.isFetching = false
                    print("Successfully Fetched News")
                case .failure(let error):
                    self?.showFetchNewsButton = true
                    self?.isFetching = false
                    print("Unable to Fetch News \(error)")
                    self?.errorMessage = APIErrorMapper(
                        error: error,
                        context: .results
                    ).message
                }
            }, receiveValue: { [weak self] results in
                self?.isFetching = false
                self?.populateRowViewModels(results.results)
                
            }).store(in: &subscriptions)
    }
    
    func populateRowViewModels(_ results: [GameResult]) {
        var resultArray: [GameResult] = results
        
        resultArray = results.sorted { $0.date > $1.date }
        guard let referenceDate = results.first?.date else {
            return
        }
        
        self.newsDate = referenceDate
        
        resultArray = resultArray.filter({Calendar.current.isDate($0.date, equalTo: referenceDate, toGranularity: .day)})
        
        self.resultViewModels = resultArray.map(ResultViewModel.init)
    }
    
    func populateResultHeader() -> String {
        if let date = newsDate {
            return "Resuts for \(date.formatted(.iso8601.month().day().year().dateSeparator(.dash)))"
        }
        return "Results"
    }
    
}
