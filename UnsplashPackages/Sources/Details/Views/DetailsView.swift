//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import DesignSystem
import SwiftUI
import Utils

struct DetailsView: View {
    let viewModel: DetailsViewModel

    @State var nbLikes = 0
    @Environment(Routing.self) private var routing

    var body: some View {
        MainContainer {
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    UnsplashWebImage(path: viewModel.urlPhoto) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()


                    } placeholder: {
                        Color.gray
                            .opacity(0.2)
                            .frame(height: 250)
                    }
                    .padding(.bottom, Margins.medium)

                    Button {
                        routing.presentSheet(destination: Destination.highResolution)
                    } label: {

                        Image(systemName: "plus.magnifyingglass")
                            .foregroundColor(DSColors.whiteText.swiftUIColor)
                            .font(.title)
                            .padding(8)
                            .background(
                                Color.black
                                    .opacity(0.3)
                                    .cornerRadius(8)

                            )
                            .padding()
                    }
                    .padding()
                    .accessibilityIdentifier("highResolution")
                }

                HStack {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundStyle(Color.red)
                    Text(.localizable.homeLikeTitle(nbLikes))
                        .contentTransition(.numericText())
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(DSColors.whiteText.swiftUIColor)
                        .animate(.easeInOut.delay(0.2), value: nbLikes)
                }
                .padding(.trailing, Margins.medium)

                VStack(alignment: .leading) {
                    Text(viewModel.description)
                        .font(.callout)
                        .bold()
                        .foregroundStyle(DSColors.whiteText.swiftUIColor)
                        .padding(.bottom, Margins.medium)

                    PhotographerView(
                        username: viewModel.username,
                        url: viewModel.urlProfilePhoto
                    )
                    Spacer()
                }
                .padding()
            }

        }
        .navigationTitle("\(.localizable.detailsViewTitle)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                nbLikes = viewModel.nbLikes
            }
        }

    }
}

struct PhotographerView: View {
    let username: String
    let url: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(.localizable.detailsPhotographerTitle)")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(DSColors.whiteText.swiftUIColor)
                    .underline()

                HStack {
                    ProfilePhotoCell(url: url)
                        .frame(width: 64, height: 64)
                    Text(username)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(DSColors.whiteText.swiftUIColor)
                }
            }

            Spacer()
        }

    }
}

/*
#Preview {
    DetailsView()
}*/
