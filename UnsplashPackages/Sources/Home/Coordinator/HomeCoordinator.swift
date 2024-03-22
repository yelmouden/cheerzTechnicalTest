//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import SwiftUI
import Utils

public struct HomeCoordinator: View {
    private let viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        HomeView(viewModel: viewModel)
            .navigationDestination(for: Destination.self) { _ in
            }
    }
}
