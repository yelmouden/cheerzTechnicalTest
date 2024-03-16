//
//  ContentView.swift
//  Unsplah
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Home
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
                    Image(systemName: "house.fill")
                    Text("First")
                }

            Text("Tab 2")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }

            Text("Tab 3")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Third")
                }
        }
    }
}

#Preview {
    AppView()
}
