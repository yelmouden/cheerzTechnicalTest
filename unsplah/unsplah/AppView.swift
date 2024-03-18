//
//  ContentView.swift
//  Unsplah
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import DesignSystem
import Home
import Localizable
import SwiftUI
import Utils

struct AppView: View {
    let homeRouting = Routing()

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

            Text("Tab 2")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
        .accentColor(DSColors.whiteText.swiftUIColor)
        
    }
}

#Preview {
    AppView()
}
