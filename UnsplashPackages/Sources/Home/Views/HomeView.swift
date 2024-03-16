//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import AppConfiguration
import Dependencies
import SharedModels
import SwiftUI
import Utils

struct HomeView: View {
    private let viewModel: HomeViewModel
    @Environment(Routing.self) private var routing

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            
        }
        .navigationTitle("Home")

    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: withDependencies {
            $0.homeRepository = .init(getListPhotos: {
                [Photo(id: "")]
            })
        } operation: {
            HomeViewModel()
        })
    }
    .environment(Routing())
}
