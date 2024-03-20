//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import AppConfiguration
import Dependencies
import DesignSystem
import SharedModels
import SwiftUI
import Utils

struct HomeView: View {
    private let viewModel: HomeViewModel
    private let columns = [GridItem(.adaptive(minimum: 180, maximum: .infinity), spacing: 0)]

    @Environment(Routing.self) private var routing

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        MainContainer {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                LoaderView()
                    .frame(width: 30, height: 30)
            case .loaded(let photos):
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(photos) { photo in
                            Button {
                                routing.push(destination: PublicDestination.details(photo))
                            } label: {
                                PhotoCell(
                                    urlPhoto: photo.urlsPhotoType.small,
                                    userName: photo.user.username,
                                    urlUserProfile: photo.user.urlsProfilePhotoType.small,
                                    nbLikes: photo.likes
                                )
                            }
                            .scrollTransition { content, phase in
                                content
                                    .blur(radius: phase.value > -1 ? 0 : 4)

                            }
                        }
                    }
                    .padding(.bottom, Margins.medium)

                }
                .transition(.move(edge: .bottom))
                .refreshable {
                    await viewModel.retrieve()
                }

            case .error:
                ErrorView(retry: {
                    Task {
                        await viewModel.retrieve()
                    }
                })
            }
        }
        .animate(.bouncy, value: viewModel.state)
        .navigationTitle("\(.localizable.homeViewTitle)")
        .task {
            await viewModel.retrieve()
        }
    }
}

/*
#Preview {
    NavigationStack {
        HomeView(viewModel: withDependencies {
            $0.homeRepository = .init(getListPhotos: {
                [Photo(
                    id: "",
                    likes: 10,
                    urlsPhotoType: .init(
                        raw: "",
                        full: "",
                        regular: "",
                        small: "",
                        thumb: ""
                    ),
                    user: .init(
                        username: "",
                        urlsProfilePhotoType: .init(
                            small: "",
                            medium: "",
                            large: ""
                        )
                    )
                )]
            })
        } operation: {
            HomeViewModel()
        })
    }
    .environment(Routing())
}
*/
