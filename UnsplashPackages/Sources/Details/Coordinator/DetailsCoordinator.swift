//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import SharedModels
import SwiftUI
import Utils


public struct DetailsCoordinator: View {
    @Environment(Routing.self) private var routing

    let detailsViewModel: DetailsViewModel
    private let photo: Photo

    public init(photo: Photo) {
        self.detailsViewModel = DetailsViewModel(photo: photo)
        self.photo = photo
    }

    public var body: some View {
        @Bindable var routing = routing

        DetailsView(viewModel: detailsViewModel)
            .navigationDestination(for: Destination.self) { _ in
            }
            .sheet(item: $routing.presentedSheet) { value in
                if let destination = value.destination as? Destination {
                    switch destination {
                    case .highResolution:
                        HighResolutionPhotoView(viewModel: .init(photo: photo))
                    }
                }
            }
    }
}
/*
#Preview {
    DetailsCoordinator()
}*/
