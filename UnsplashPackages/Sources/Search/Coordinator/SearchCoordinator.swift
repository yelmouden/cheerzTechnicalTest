//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import SwiftUI
import Utils

public struct SearchCoordinator: View {
    private let viewModel:SearchViewModel

    public init(viewModel:SearchViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        SearchView(viewModel: viewModel)
            .navigationDestination(for: Destination.self) { _ in
            }

    }
}

/*
#Preview {
    SearchCoordinator()
}*/
