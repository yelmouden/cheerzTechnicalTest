//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import SwiftUI
import Utils

public struct HomeCoordinator: View {
    private let homeViewModel = HomeViewModel()

    public init() {
    }

    public var body: some View {
        HomeView(viewModel: homeViewModel)
            .navigationDestination(for: Destination.self) { _ in

            }

    }
}

#Preview {
    HomeCoordinator()
}
