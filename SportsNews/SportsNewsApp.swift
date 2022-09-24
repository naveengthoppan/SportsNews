//
//  SportsNewsApp.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 22/09/2022.
//

import SwiftUI

@main
struct SportsNewsApp: App {
    var body: some Scene {
        WindowGroup {
            SportsNewsListView(viewModel: SportsNewsListViewModel(apiService: APIClient()))
        }
    }
}
