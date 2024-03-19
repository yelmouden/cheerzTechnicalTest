//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import DesignSystem
import Localizable
import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""

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
                        .bold()
                        .font(.title2)
                } else {
                    ScrollView {
                        VStack {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(photos) { photo in
                                    PhotoCell(
                                        urlPhoto: photo.urlsPhotoType.small,
                                        userName: photo.user.username,
                                        urlUserProfile: photo.user.urlsProfilePhotoType.small,
                                        nbLikes: photo.likes
                                    )
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
                }

            case .error:
                Text(.localizable.errorViewTitle)
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("\(.localizable.searchViewTitle)")
        .task(id: searchText) {
            await viewModel.search(text: searchText)
        }
    }
}

struct MyView: View {
    var body: some View {
        Text("ceci est un test")
            .onAppear {
                print("ça passe par la")
            }
    }
}

/*
#Preview {
    SearchView()
}*/
