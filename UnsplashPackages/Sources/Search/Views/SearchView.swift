//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import DesignSystem
import Localizable
import SwiftUI
import Utils

struct SearchView: View {
    @State var searchText: String = ""
    @Environment(Routing.self) private var routing

    private let columns = [GridItem(.adaptive(minimum: 180, maximum: .infinity), spacing: 0)]
    private let viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
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
                if photos.isEmpty {
                    Text(.localizable.searchNotFoundTitle)
                        .foregroundStyle(DSColors.whiteText.swiftUIColor)
                        .bold()
                        .font(.title2)
                } else {
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
                            }

                            Color.clear
                                .frame(width: 0, height: 0)
                                .onAppear {
                                    viewModel.loadNextPage()
                                }
                        }
                        .padding(.bottom, Margins.medium)
                    }
                }

            case .error:
                Text(.localizable.errorViewTitle)
                    .foregroundStyle(DSColors.whiteText.swiftUIColor)
            }
        }
        .searchable(text: $searchText)
        .foregroundColor(DSColors.whiteText.swiftUIColor)
        .navigationTitle("\(.localizable.searchViewTitle)")
        .task(id: searchText) {
            await viewModel.search(text: searchText)
        }
    }
}

