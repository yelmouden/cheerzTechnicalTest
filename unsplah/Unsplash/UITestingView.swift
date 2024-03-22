//
//  UITestingView.swift
//  Unsplah
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import Dependencies
import SwiftUI

@testable import Home
@testable import Search

struct UITestingView: View {
    let name: String

    var body: some View {
        withDependencies {
            if name == "testNavigationHomeScreenToHighResolutionScreen" {
                $0.homeRepository = .init(getListPhotos: {
                    [
                        .init(
                            id: "1",
                            description: "this is a description",
                            altDescription: nil,
                            likes: 20,
                            urlsPhotoType: .init(
                                raw: "",
                                full: "",
                                regular: "",
                                small: "",
                                thumb: ""
                            ),
                            user: .init(
                                username: "username 1",
                                urlsProfilePhotoType: .init(
                                    small: "",
                                    medium: "",
                                    large: ""
                                )
                            )
                        )
                    ]
                })
            } else {
                $0.homeRepository = .init(getListPhotos: {
                    []
                })

                $0.seachRepository = .init(search: { _, _ in
                        .init(
                            totalPages: 1,
                            photos:
                                [
                                    .init(
                                        id: "1",
                                        description: "this is a description",
                                        altDescription: nil,
                                        likes: 20,
                                        urlsPhotoType: .init(
                                            raw: "",
                                            full: "",
                                            regular: "",
                                            small: "",
                                            thumb: ""
                                        ),
                                        user: .init(
                                            username: "username 1",
                                            urlsProfilePhotoType: .init(
                                                small: "",
                                                medium: "",
                                                large: ""
                                            )
                                        )
                                    )
                                ]
                        )
                })
            }
        } operation: {
            AppView(
                homeViewModel: HomeViewModel(),
                searchViewModel: SearchViewModel()
            )
        }

    }
}
