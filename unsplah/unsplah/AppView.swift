//
//  ContentView.swift
//  Unsplah
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import DesignSystem
import Home
import Localizable
import Search
import SDWebImageSwiftUI
import SwiftUI
import Utils

struct AppView: View {
    let homeRouting = Routing()
    let searchRouting = Routing()

    var body: some View {
        TabView {
            NavigationStack {
                HomeCoordinator()
                    .navigationDestination(for: Home.PublicDestination.self) { _ in
                        EmptyView()
                    }
            }
            .environment(homeRouting)
            .tabItem {
                    Image(systemName: "house")
                Text("\(.localizable.homeViewTitle)")
                }

            NavigationStack {
                SearchCoordinator()
                    .navigationDestination(for: Search.PublicDestination.self) { _ in
                        EmptyView()
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
