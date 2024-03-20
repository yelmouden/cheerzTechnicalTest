//
//  ContentView.swift
//  Unsplah
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import DesignSystem
import Details
import Home
import Localizable
import Search
import SDWebImageSwiftUI
import SwiftUI
import Utils

struct AppView: View {
    // Home feature
    let homeViewModel: HomeViewModel
    @Bindable var homeRouting = Routing()

    // Search feature
    let searchViewModel: SearchViewModel
    @Bindable var searchRouting = Routing()


    init(
        homeViewModel: HomeViewModel = HomeViewModel(),
        searchViewModel: SearchViewModel = SearchViewModel()
    ) {
        self.homeViewModel = homeViewModel
        self.searchViewModel = searchViewModel
    }

    var body: some View {
        TabView {
            NavigationStack(path: $homeRouting.path) {
                HomeCoordinator(viewModel: homeViewModel)
                    .navigationDestination(for: Home.PublicDestination.self) { destination in
                        switch destination {
                        case .details(let photo):
                            DetailsCoordinator(photo: photo)
                        }
                    }
            }
            .environment(homeRouting)
            .tabItem {
                    Image(systemName: "house")
                Text("\(.localizable.homeViewTitle)")
                }

            NavigationStack(path: $searchRouting.path) {
                SearchCoordinator(viewModel: searchViewModel)
                    .navigationDestination(for: Search.PublicDestination.self) { destination in
                        switch destination {
                        case .details(let photo):
                            DetailsCoordinator(photo: photo)
                        }
                    }
            }
            .environment(searchRouting)
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("\(.localizable.searchViewTitle)")
            }
        }
        .accentColor(DSColors.whiteText.swiftUIColor)

    }
}

#Preview {
    AppView()
}
